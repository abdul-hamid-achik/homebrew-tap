# typed: false
# frozen_string_literal: true

# Source-build formula for cairntrace (Bun/TypeScript). Unlike the Go-based
# taps here, cairntrace bundles Playwright, which does not `bun build --compile`
# to a standalone binary cleanly, so we install from the tag source tarball and
# `bun install` at build time. A runtime browser is installed on demand (caveat).
class Cairntrace < Formula
  desc "Behavioral browser-spec layer for agent-in-session use"
  homepage "https://github.com/abdul-hamid-achik/cairntrace"
  url "https://github.com/abdul-hamid-achik/cairntrace/archive/refs/tags/v1.47.0.tar.gz"
  version "1.47.0"
  sha256 "449eaabbfa8eda396df71fe75d9d1d6acab565a27509f4b75a03aac11b1e770e"
  license "MIT"

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
      cairntrace runs browser specs via Playwright. Install Chromium once:
        bunx playwright install chromium
      (or `bunx playwright install --with-deps chromium` on Linux).
    EOS
  end

  test do
    assert_match version, shell_output("#{bin}/cairn --version")
  end
end
