# typed: false
# frozen_string_literal: true

# Source-build formula for cairntrace (Bun/TypeScript). Unlike the Go-based
# taps here, cairntrace bundles Playwright, which does not `bun build --compile`
# to a standalone binary cleanly, so we install from the tag source tarball and
# `bun install` at build time. A runtime browser is installed on demand (caveat).
class Cairntrace < Formula
  desc "Behavioral browser-spec layer for agent-in-session use"
  homepage "https://github.com/abdul-hamid-achik/cairntrace"
  url "https://github.com/abdul-hamid-achik/cairntrace/archive/refs/tags/v2.11.1.tar.gz"
  sha256 "ed30668240dfa0f38e3a95a3d4829a4ae0294cc26e9f40b36fae4bff6ceab5f2"
  license "MIT"

  livecheck do
    url :homepage
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "bun"

  def install
    # Install JS deps in the extracted source, then move the whole tree (incl.
    # node_modules) into libexec so the `bin/cairn` wrapper's
    # `import "../src/cli/index.ts"` resolves (libexec/bin/cairn -> libexec/src).
    system "bun", "install", "--frozen-lockfile"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/cairn" => "cairn"
  end

  def caveats
    <<~EOS
      cairntrace is a Bun shebang CLI (this formula depends on bun).

      Default backend:
        brew install vercel-labs/agent-browser/agent-browser

      Optional Playwright backend:
        bunx playwright install chromium
      (or `bunx playwright install --with-deps chromium` on Linux).
    EOS
  end

  test do
    assert_match version, shell_output("#{bin}/cairn --version")
  end
end
