# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.5/vecgrep_0.2.5_darwin_arm64.tar.gz"
      sha256 "f7a42cd34708fde9d85743c4965965aa0be2a335bc3781c586b048c5e2d18e88"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.5/vecgrep_0.2.5_darwin_amd64.tar.gz"
      sha256 "093f1c2a4b92941c256e2a4f04dd8710673ac8fe4b8cd7b6cccb3855eb78a29c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.5/vecgrep_0.2.5_linux_amd64.tar.gz"
      sha256 "bb265b20b98769771442368f31d61959dd26195d7f3a9983553edcc165abbe23"
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
