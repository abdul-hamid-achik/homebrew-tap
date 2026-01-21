# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.0/vecgrep_0.4.0_darwin_arm64.tar.gz"
      sha256 "d2e4b52dfa3a4bdb64a80823a76c9e230f727620f2a319d6e58973909051f975"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.0/vecgrep_0.4.0_darwin_amd64.tar.gz"
      sha256 "4a1577315cb2ec1f0151a6a6304aabcb732b9d097fc6975e4fb112ca59d25eac"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.0/vecgrep_0.4.0_linux_amd64.tar.gz"
      sha256 "cd3d70d84777dcb9975e8deebee407e0f4758a91970ce3ebea956190a45ec8a7"
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
