# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.4/vecgrep_0.2.4_darwin_arm64.tar.gz"
      sha256 "541bcf060b0fd005b003a1901adfd4e63327d49ce6bb53045ff2cd2d4cd8391f"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.4/vecgrep_0.2.4_darwin_amd64.tar.gz"
      sha256 "3a2ff35fbbb21f4e12230ab63bc3e65d570fad12d856482e279edb6cd474d0f5"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.4/vecgrep_0.2.4_linux_amd64.tar.gz"
      sha256 "d47a10d80811d508147aadb94c44a3ab57fda352515c2f625195d874e15ce2ef"
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
