# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.0/vecgrep_0.2.0_darwin_arm64.tar.gz"
      sha256 "96b0a8b173d785d578c6e2135b30e7e8dbf93721b51f37aa71de753910d0b227"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.0/vecgrep_0.2.0_darwin_amd64.tar.gz"
      sha256 "cb1e322dd568da1ebeff0b90d3c06a1a613c670a9711c8bb02a9a4147ad03465"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.0/vecgrep_0.2.0_linux_amd64.tar.gz"
      sha256 "fe48e545061c6966b9349d40cf37dfe69ab95ab7d3e2cc791d49e359c4365e12"
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
