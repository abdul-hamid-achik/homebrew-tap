# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.6/vecgrep_0.2.6_darwin_arm64.tar.gz"
      sha256 "79f23f23118cc3aa596bfbf6e19752d29a1623146fde84a066ba00104a99d927"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.6/vecgrep_0.2.6_darwin_amd64.tar.gz"
      sha256 "cbb952074004a62c53048da1687e6c1ae6129406a731e6e43584e92509dd540f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.6/vecgrep_0.2.6_linux_amd64.tar.gz"
      sha256 "463d8254c43ae8f04e470eaad977627cd34776a7681c0f4ee0148c3cf5fb3b94"
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
