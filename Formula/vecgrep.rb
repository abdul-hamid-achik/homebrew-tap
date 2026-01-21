# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.1/vecgrep_0.3.1_darwin_arm64.tar.gz"
      sha256 "bbada63c837d8007d869749e832153efbf2774791a8817fd7505afad0ba366f8"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.1/vecgrep_0.3.1_darwin_amd64.tar.gz"
      sha256 "deb9e476e036d94c83f76dbbc82e75459eee43cbf9d78a2fc439e3fbb2499bde"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.3.1/vecgrep_0.3.1_linux_amd64.tar.gz"
      sha256 "f7660df78c838b3bb4d75c815bc30901620dc40e5653624d1be319cb241bfbea"
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
