# abdul-hamid-achik/tap

```bash
brew tap abdul-hamid-achik/tap
brew install cairntrace
```

Cairntrace is also on npm as [`@thelacanians/cairntrace`](https://www.npmjs.com/package/@thelacanians/cairntrace). Formula updates land automatically when a `v*` tag is pushed to [cairntrace](https://github.com/abdul-hamid-achik/cairntrace).

## Casks

Prebuilt CLIs are published as casks (`brew install --cask abdul-hamid-achik/tap/<name>`): bob, codemap, cortex, fcheap, glyph, hitspec, mcphub, minerva, monitor, tuimark, tvault, vecai, veclite, vidtrace. The binaries are unsigned; each cask clears the Gatekeeper quarantine flag on install with a declarative `postflight_steps` stanza.

## Moving from a formula to a cask

`hitspec` and `vecai` used to ship as formulae and are now casks only. `brew update` migrates an installed formula automatically (it unlinks the keg and installs the cask). To do it by hand:

```bash
brew uninstall --formula hitspec   # or vecai
brew install --cask abdul-hamid-achik/tap/hitspec
```

## Deprecated

- `fc` (old file.cheap CLI): replaced by `brew install --cask abdul-hamid-achik/tap/fcheap`.
- `gpeek`: now a native Swift macOS app, not distributed here.
- `local-agent`: being rewritten in Bun/TypeScript; no standalone release yet.
