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
      sha256 "1794de370f8ba69b8794bfddb01ffc9097ac726ca31a49efb157bb1c80c32d97"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.0/vecgrep_0.2.0_darwin_amd64.tar.gz"
      sha256 "02a434100ad4f12946bf1897ed7496df2d1b72d2c98ecbb734231369570289ab"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.0/vecgrep_0.2.0_linux_amd64.tar.gz"
      sha256 "71efc4af4ba47a8ab034a15b96d86e1e5bd108c3ce6b5f08e069dea81f4ee365"
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
