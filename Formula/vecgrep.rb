# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.7/vecgrep_0.2.7_darwin_arm64.tar.gz"
      sha256 "b1e0588b7744b1c01026068371f96887ebe16360573574b39b035a734938f1a5"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.7/vecgrep_0.2.7_darwin_amd64.tar.gz"
      sha256 "21c36e42f5f81f9c073546a40f8a427b02d6c39afe728a1b64617bebd1afa568"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.7/vecgrep_0.2.7_linux_amd64.tar.gz"
      sha256 "03697eb4bece236fca5adb8df1d740bec5fa34496f46a767ba2b7bf30092787a"
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
