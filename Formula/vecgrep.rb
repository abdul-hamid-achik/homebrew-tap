# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.8/vecgrep_0.2.8_darwin_arm64.tar.gz"
      sha256 "d1c5585360f5d77a220a408f9a9709d6aed905d045ed52f0cffc629f1b42328c"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.8/vecgrep_0.2.8_darwin_amd64.tar.gz"
      sha256 "b0527f4930b9fda7b0b7cd34002f465843dfb6866825b961beb5e040d5556cf4"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.8/vecgrep_0.2.8_linux_amd64.tar.gz"
      sha256 "3ce09d9f3b007c7e44f1e4ef5b2da2c15607b55b28f946627aed28ecd3d6cf36"
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
