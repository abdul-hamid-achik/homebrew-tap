# This file was generated from the verified VecLite v0.23.1 release assets.
cask "veclite" do
  version "0.23.1"

  on_macos do
    on_intel do
      sha256 "cbba07e246f07084f69e70113fb4aca9f58a2c26f347955da0bb3f4c4c7420f8"
      url "https://github.com/abdul-hamid-achik/veclite/releases/download/v#{version}/veclite_#{version}_darwin_amd64.tar.gz"
    end
    on_arm do
      sha256 "9f8c920e9598c2644b7fd2f1c4fe1667f0babe78855136720cc8909f0651fc6b"
      url "https://github.com/abdul-hamid-achik/veclite/releases/download/v#{version}/veclite_#{version}_darwin_arm64.tar.gz"
    end
  end

  on_linux do
    on_intel do
      sha256 "56d479afc3a8895eadbae03e6ff73c31c27ef746f6ed7ad1506fb2678e71cba9"
      url "https://github.com/abdul-hamid-achik/veclite/releases/download/v#{version}/veclite_#{version}_linux_amd64.tar.gz"
    end
    on_arm do
      sha256 "bb59ee6fdd0fb3b888b4a25bab47d0ec93e299df4895ac5b86a838db0b926cb1"
      url "https://github.com/abdul-hamid-achik/veclite/releases/download/v#{version}/veclite_#{version}_linux_arm64.tar.gz"
    end
  end

  name "veclite"
  desc "SQLite for vectors. Embed anywhere, no servers, one file"
  homepage "https://github.com/abdul-hamid-achik/veclite"

  livecheck do
    skip "Auto-generated on release."
  end

  binary "veclite"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{staged_path}/veclite"] if OS.mac?
  end

  # No zap stanza required

  caveats <<~EOS
    The veclite binary is not Apple-notarized; this cask clears its quarantine attribute during installation.
  EOS
end
