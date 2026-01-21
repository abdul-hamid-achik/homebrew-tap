# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.4.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.1/vecgrep_0.4.1_darwin_arm64.tar.gz"
      sha256 "4afcee19ceba3a87690740fef371a92cab4e97f578bb08341cf6c721d8775231"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.1/vecgrep_0.4.1_darwin_amd64.tar.gz"
      sha256 "57962174c1bbee781897e8bfdcdd84c76142ce925f01fe81f863cc7f2663e6fc"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.4.1/vecgrep_0.4.1_linux_amd64.tar.gz"
      sha256 "e49f542d3b2c12fefbe7d72c9639258a2fba9bce67a0f91389183e8a911ed07b"
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
