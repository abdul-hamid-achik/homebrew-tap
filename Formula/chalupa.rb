# typed: false
# frozen_string_literal: true

# Source-build formula for chalupa (Bun/TypeScript): installs from the tag
# source tarball and `bun install` at build time, symlinking bin/chalupa (a
# `#!/usr/bin/env bun` wrapper). The repo must be public for codeload to
# serve the tarball.
class Chalupa < Formula
  desc "Ephemeral Docker Compose environments on DigitalOcean, SSH-only"
  homepage "https://github.com/abdul-hamid-achik/chalupa"
  url "https://github.com/abdul-hamid-achik/chalupa/archive/refs/tags/v0.9.0.tar.gz"
  version "0.9.0"
  sha256 "REPLACE_WITH_SHA256"
  license "MIT"

  depends_on "bun"

  def install
    system "bun", "install", "--frozen-lockfile"
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/chalupa" => "chalupa"
  end

  def caveats
    <<~EOS
      chalupa provisions droplets on YOUR DigitalOcean account. First run:
        chalupa doctor
      to check the prerequisites (bun, tvault, an SSH key registered in DO).
    EOS
  end

  test do
    assert_match(/chalupa|version/i, shell_output("#{bin}/chalupa --version"))
  end
end
