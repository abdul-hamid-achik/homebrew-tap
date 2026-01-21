# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.1/vecgrep_0.3.1_darwin_arm64.tar.gz"
      sha256 "ffb2b588662c023723ab7d58b17c2a89ea877d6731d24f682f37e938a8899063"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.1/vecgrep_0.3.1_darwin_amd64.tar.gz"
      sha256 "da019a5d7314c2db78878bbe455324e93c0ec9f0731a08f89ff967d8c3ae2eb0"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.1/vecgrep_0.3.1_linux_amd64.tar.gz"
      sha256 "7515b4eb80faebf0bd4f3afcba48b8c3eb8d480d1195853daf5430ae929286d0"
    end
  end

  depends_on "ollama" => :optional

  def install
    bin.install "vecgrep"
  end

  test do
    system "#{bin}/vecgrep", "--version"
  end
end
