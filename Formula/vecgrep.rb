# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.1/vecgrep_0.2.1_darwin_arm64.tar.gz"
      sha256 "a663ca9bd32be34bbc3a22dba9401bfba10c6e872bf1ad974a911b6f82e65a2e"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.1/vecgrep_0.2.1_darwin_amd64.tar.gz"
      sha256 "9d9f35d2ddab4ff57763a9f9c376925281125b8231ab5107cb7780d9a9c7943b"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.1/vecgrep_0.2.1_linux_amd64.tar.gz"
      sha256 "a3df26228e5d10f3ad3d6325474cc793c67bcdadeaacff5e00273cfd2a74527a"
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
