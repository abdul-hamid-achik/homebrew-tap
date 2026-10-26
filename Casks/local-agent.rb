# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.56.0"

  on_macos do
    on_arm do
      sha256 "bab8174176819d678438d2c2fd37843bc73982e093b98d4e0b1052751f43ea82"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "9ea2bea8264f9dbe06d4c07d4332907d35f5640745b81c1218a63af784a0a6cc"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "75fe71eaae78b01e2cf1db41ead1b037c0dfb68a29be153dd62339892d6ff2c0"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "248ec909a12d19bde777c39fc27571c6714d71235a2bbbea0d69fa71409641d0"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_amd64.tar.gz"
    end
  end

  name "local-agent"
  desc "Local coding agent for Ollama, with a terminal UI and MCP tools"
  homepage "https://local-agent.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "local-agent"

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{staged_path}}"]
    end
  end

  # No zap stanza required
end
