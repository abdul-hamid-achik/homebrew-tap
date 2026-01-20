# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.0/vecgrep_0.3.0_darwin_arm64.tar.gz"
      sha256 "97511a43324181fc2a5fbd1a941e55c76a36617267a26cdfa0201e0f1e95b5be"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.0/vecgrep_0.3.0_darwin_amd64.tar.gz"
      sha256 "8b2eb58d7555d829194be806c4210d7327d8007495e21aa69ecabdf9b4939b5e"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.0/vecgrep_0.3.0_linux_amd64.tar.gz"
      sha256 "dcfa0e65c3c03e6f302c09648631b7d91be5280c306c34ef2bc792cfd73b03c4"
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
