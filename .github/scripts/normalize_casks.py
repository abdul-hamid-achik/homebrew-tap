#!/usr/bin/env python3
"""Rewrite GoReleaser's legacy cask `postflight do ... end` into `postflight_steps`.

TEMPORARY. GoReleaser <= v2.18 renders `homebrew_casks.hooks.post.install` as a
legacy Ruby `postflight do ... end` block, which Homebrew 7 deprecates for
third-party taps (disabled 2027-12-11). GoReleaser will emit declarative
`postflight_steps` itself once v2.19 ships `install_steps`:
https://github.com/goreleaser/goreleaser/pull/6873
Delete this script, its tests and normalize-casks.yml when every feeding repo
has switched to `install_steps`.

Recognised shapes (the only two GoReleaser hooks in our repos emit):

    postflight do
      if OS.mac?
        system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/BIN"]
      end
    end

    postflight do
      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/BIN"] if OS.mac?
    end

Both become:

    postflight_steps do
      on_macos do
        run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/BIN"]
      end
    end

Any other postflight block is refused: the script exits 1 and writes nothing.
Idempotent: files without a legacy block are left byte-for-byte untouched.

Usage: normalize_casks.py [--check] [FILE ...]   (default: Casks/*.rb)
  --check  write nothing; exit 2 if any file would change.
Exit codes: 0 ok / nothing to do, 1 unrecognised block or error, 2 --check found changes.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

BIN = r"[A-Za-z0-9][A-Za-z0-9._+-]*"
XATTR = (
    r'system_command "/usr/bin/xattr", '
    r'args: \["-dr", "com\.apple\.quarantine", "#\{staged_path\}/(?P<bin>' + BIN + r')"\]'
)
MULTILINE_FORM = re.compile(r"if OS\.mac\?\n" + XATTR + r"\nend")
ONELINE_FORM = re.compile(XATTR + r" if OS\.mac\?")

# A whole `postflight do ... end` block; `end` must sit at the same indent.
BLOCK = re.compile(
    r"^(?P<indent>[ \t]*)postflight[ \t]+do[ \t]*\n(?P<body>.*?)^(?P=indent)end[ \t]*\n",
    re.MULTILINE | re.DOTALL,
)
# Any legacy postflight mention (but not `postflight_steps`).
LEGACY_MENTION = re.compile(r"^[ \t]*postflight\b(?!_steps)", re.MULTILINE)
OTHER_LEGACY = re.compile(r"^[ \t]*(preflight|uninstall_preflight|uninstall_postflight)[ \t]+do\b", re.MULTILINE)


class Unrecognised(Exception):
    pass


def _binary_from_body(body: str) -> str | None:
    lines = [ln.strip() for ln in body.splitlines() if ln.strip()]
    text = "\n".join(lines)
    for form in (MULTILINE_FORM, ONELINE_FORM):
        m = form.fullmatch(text)
        if m:
            return m.group("bin")
    return None


def _render(indent: str, binary: str) -> str:
    return (
        f"{indent}postflight_steps do\n"
        f"{indent}  on_macos do\n"
        f'{indent}    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{{{staged_path}}}}/{binary}"]\n'
        f"{indent}  end\n"
        f"{indent}end\n"
    )


def normalize_text(text: str) -> str:
    """Return the rewritten text (identical to `text` when nothing to do).

    Raises Unrecognised for any postflight block not matching a known shape.
    """
    if not LEGACY_MENTION.search(text):
        return text

    def sub(m: re.Match) -> str:
        binary = _binary_from_body(m.group("body"))
        if binary is None:
            raise Unrecognised("unrecognised postflight body:\n" + m.group(0))
        return _render(m.group("indent"), binary)

    new = BLOCK.sub(sub, text)
    if LEGACY_MENTION.search(new):
        raise Unrecognised("postflight stanza not in `postflight do ... end` form")
    if "postflight_steps" in text:
        raise Unrecognised("file has both a legacy postflight and a postflight_steps stanza")
    return new


def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("files", nargs="*", help="cask files (default: Casks/*.rb)")
    ap.add_argument("--check", action="store_true", help="write nothing; exit 2 if changes are needed")
    args = ap.parse_args(argv)

    files = [Path(f) for f in args.files] or sorted(Path("Casks").glob("*.rb"))
    if not files:
        print("no cask files found", file=sys.stderr)
        return 1

    pending: list[tuple[Path, str]] = []
    failed = False
    for path in files:
        try:
            text = path.read_text()
            new = normalize_text(text)
        except Unrecognised as exc:
            print(f"ERROR {path}: {exc}", file=sys.stderr)
            failed = True
            continue
        if OTHER_LEGACY.search(text):
            print(f"warning {path}: other legacy flight block present (not rewritten)", file=sys.stderr)
        if new != text:
            pending.append((path, new))

    if failed:
        print("refusing to change anything", file=sys.stderr)
        return 1
    for path, _ in pending:
        print(f"{'would rewrite' if args.check else 'rewrote'} {path}")
    if args.check:
        return 2 if pending else 0
    for path, new in pending:
        path.write_text(new)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
