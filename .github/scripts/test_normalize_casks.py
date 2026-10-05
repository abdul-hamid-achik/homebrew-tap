"""Tests for normalize_casks.py. Run: python3 .github/scripts/test_normalize_casks.py"""
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))
import normalize_casks as nc  # noqa: E402

HEAD = 'cask "demo" do\n  version "1.0.0"\n\n  binary "demo"\n\n'
TAIL = '\n  # No zap stanza required\nend\n'

MULTI = (
    "  postflight do\n"
    "    if OS.mac?\n"
    '      system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/demo"]\n'
    "    end\n"
    "  end\n"
)
ONE = (
    "  postflight do\n"
    '    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/demo"] if OS.mac?\n'
    "  end\n"
)
STEPS = (
    "  postflight_steps do\n"
    "    on_macos do\n"
    '      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}/demo"]\n'
    "    end\n"
    "  end\n"
)
UNKNOWN = (
    "  postflight do\n"
    '    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/demo"]\n'
    '    system_command "/bin/echo", args: ["hi"]\n'
    "  end\n"
)


class NormalizeText(unittest.TestCase):
    def test_multiline_form(self):
        self.assertEqual(nc.normalize_text(HEAD + MULTI + TAIL), HEAD + STEPS + TAIL)

    def test_oneline_form(self):
        self.assertEqual(nc.normalize_text(HEAD + ONE + TAIL), HEAD + STEPS + TAIL)

    def test_trailing_blank_line_in_body(self):
        text = MULTI.replace("    end\n  end\n", "    end\n\n  end\n")
        self.assertEqual(nc.normalize_text(HEAD + text + TAIL), HEAD + STEPS + TAIL)

    def test_binary_name_with_dash(self):
        text = ONE.replace("demo", "local-agent")
        out = nc.normalize_text(HEAD + text + TAIL)
        self.assertIn("{{staged_path}}/local-agent", out)
        self.assertNotIn("postflight do", out)

    def test_idempotent(self):
        once = nc.normalize_text(HEAD + MULTI + TAIL)
        self.assertEqual(nc.normalize_text(once), once)
        self.assertEqual(nc.normalize_text(HEAD + STEPS + TAIL), HEAD + STEPS + TAIL)

    def test_no_postflight_untouched(self):
        text = HEAD.rstrip("\n") + "\nend\n"
        self.assertEqual(nc.normalize_text(text), text)

    def test_unrecognised_body_refused(self):
        with self.assertRaises(nc.Unrecognised):
            nc.normalize_text(HEAD + UNKNOWN + TAIL)

    def test_other_command_refused(self):
        text = ONE.replace("/usr/bin/xattr", "/bin/rm")
        with self.assertRaises(nc.Unrecognised):
            nc.normalize_text(HEAD + text + TAIL)

    def test_other_attribute_refused(self):
        text = ONE.replace("com.apple.quarantine", "com.apple.provenance")
        with self.assertRaises(nc.Unrecognised):
            nc.normalize_text(HEAD + text + TAIL)

    def test_both_legacy_and_steps_refused(self):
        with self.assertRaises(nc.Unrecognised):
            nc.normalize_text(HEAD + MULTI + "\n" + STEPS + TAIL)

    def test_brace_form_refused(self):
        with self.assertRaises(nc.Unrecognised):
            nc.normalize_text(HEAD + "  postflight { system_command 'x' }\n" + TAIL)


class Cli(unittest.TestCase):
    def run_cli(self, cwd, *args):
        return subprocess.run(
            [sys.executable, str(HERE / "normalize_casks.py"), *args],
            cwd=cwd, capture_output=True, text=True,
        )

    def make_tree(self, files):
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        casks = Path(tmp.name) / "Casks"
        casks.mkdir()
        for name, content in files.items():
            (casks / name).write_text(content)
        return Path(tmp.name)

    def test_rewrites_both_shapes_then_noop(self):
        root = self.make_tree({"a.rb": HEAD + MULTI + TAIL, "b.rb": HEAD + ONE + TAIL, "c.rb": HEAD + STEPS + TAIL})
        r = self.run_cli(root)
        self.assertEqual(r.returncode, 0, r.stderr)
        for n in ("a.rb", "b.rb", "c.rb"):
            self.assertEqual((root / "Casks" / n).read_text(), HEAD + STEPS + TAIL)
        r = self.run_cli(root, "--check")
        self.assertEqual(r.returncode, 0, r.stderr)
        self.assertEqual(r.stdout, "")

    def test_check_does_not_write(self):
        root = self.make_tree({"a.rb": HEAD + MULTI + TAIL})
        r = self.run_cli(root, "--check")
        self.assertEqual(r.returncode, 2)
        self.assertEqual((root / "Casks" / "a.rb").read_text(), HEAD + MULTI + TAIL)

    def test_unrecognised_changes_nothing_and_fails(self):
        root = self.make_tree({"a.rb": HEAD + MULTI + TAIL, "z.rb": HEAD + UNKNOWN + TAIL})
        r = self.run_cli(root)
        self.assertEqual(r.returncode, 1)
        self.assertIn("z.rb", r.stderr)
        self.assertEqual((root / "Casks" / "a.rb").read_text(), HEAD + MULTI + TAIL)
        self.assertEqual((root / "Casks" / "z.rb").read_text(), HEAD + UNKNOWN + TAIL)


if __name__ == "__main__":
    unittest.main(verbosity=2)
