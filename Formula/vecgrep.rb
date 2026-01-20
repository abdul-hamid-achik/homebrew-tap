# typed: false
# frozen_string_literal: true

class Vecgrep < Formula
  desc "Local-first semantic code search powered by embeddings"
  homepage "https://github.com/abdul-hamid-achik/vecgrep"
  license "MIT"
  version "0.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.3/vecgrep_0.2.3_darwin_arm64.tar.gz"
      sha256 "814463fbde6abdb86b7c3a8e726176ddb5424b4c692ab998bb2b16018d094761"
    else
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.3/vecgrep_0.2.3_darwin_amd64.tar.gz"
      sha256 "41db00ec31204210430b8bbcd5f4d06f01269b47d00614008c3cfe6bd7c5b145"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/abdul-hamid-achik/vecgrep/releases/download/v0.2.3/vecgrep_0.2.3_linux_amd64.tar.gz"
      sha256 "2ec2de44ef4be7b8b76e9618e24f495f6bd33389840c8353a6e93129e386485e"
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
