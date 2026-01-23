# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.4.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.2/vecgrep_0.4.2_darwin_arm64.tar.gz"
      sha256 "209217e081148f5e8a543b458967527663ca77d4a0231c1a67548e38d1da3ec3"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.2/vecgrep_0.4.2_darwin_amd64.tar.gz"
      sha256 "0e516c706879d5bb1c77a8b89490f4ff77facb1343518c2b5cd251b2d8d7ec17"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.2/vecgrep_0.4.2_linux_amd64.tar.gz"
      sha256 "9969d3f4d899a1bc758fde45027e46661317f964894a57154f010dec29ce84f1"
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
