# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.2/vecgrep_0.2.2_darwin_arm64.tar.gz"
      sha256 "dda461c5021db0b8587e24726c6e815fad9752ad2fe3ec538159ea84d5213a3e"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.2/vecgrep_0.2.2_darwin_amd64.tar.gz"
      sha256 "dde6f5361e3ca38b32b02adbcb370eca6f7b31df198af7f75d8d7cf0bf276182"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.2/vecgrep_0.2.2_linux_amd64.tar.gz"
      sha256 "ad54eabbb7042ca8d3e5de95b822d515744d28deaec9417f8402b8d485fe7c6d"
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
