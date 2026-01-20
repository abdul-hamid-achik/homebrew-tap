# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.9/vecgrep_0.2.9_darwin_arm64.tar.gz"
      sha256 "95a0752dbe0c17b8a13fa294f2ed562ffa0006ac8c54754b8bc947c9066df231"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.9/vecgrep_0.2.9_darwin_amd64.tar.gz"
      sha256 "1bdaa627ff889bbe127731b50571669b35df6a2fed061ba56b39ed027ed4280f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.9/vecgrep_0.2.9_linux_amd64.tar.gz"
      sha256 "1d884d4b0f091f2cd9a32309f1898e9613e90eeeec6d0406434d9b3157d3f3a4"
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
