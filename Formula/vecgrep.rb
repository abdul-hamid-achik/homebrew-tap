# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.1.1/vecgrep_0.1.1_darwin_arm64.tar.gz"
      sha256 "ea7ee98eb0ddd2620314404e1cce74c9214e36683c0f3e0e17d74cf7c2f55274"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.1.1/vecgrep_0.1.1_darwin_amd64.tar.gz"
      sha256 "dd5596b5b1bdc823bf3e653d827de016b6ba3ba171c782632462fcfada6c2b18"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.1.1/vecgrep_0.1.1_linux_amd64.tar.gz"
      sha256 "36c758045b2bfb1ad2cba9d46ff10758209b9279107c5a534b690f9dbc40c29d"
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
