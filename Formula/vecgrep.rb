# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.10/vecgrep_0.2.10_darwin_arm64.tar.gz"
      sha256 "699d6f3fa3047a6c47833d9df60c965d7c265a85ea2c46a388327be769d09cd6"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.10/vecgrep_0.2.10_darwin_amd64.tar.gz"
      sha256 "16ae3e39731f6ac4615c2d293016e14a11edaeabe4f43e1d9266c451c779636a"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.10/vecgrep_0.2.10_linux_amd64.tar.gz"
      sha256 "8a375a7082aaebe4f9360bf834681530ad0fbd8bc5ae018ef1062a08497f37d3"
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
