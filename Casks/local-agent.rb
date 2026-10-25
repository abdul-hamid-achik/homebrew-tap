# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.54.0"

  on_macos do
    on_arm do
      sha256 "d35e568bfb6c6bf76c6899d415e721ec5ab602af60f2bfb1ae7b8b05ed371e0b"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "4bb10451d8b765c476d42c254823c43f7668048aa8e9e94dce610afe97e7d112"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "46a671655e34b1a89737c16dbc3fe0d6457a44bd2732629dee57ef3e8cfe0c33"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "361ddae5ad1237ee1fa1a352e8a711d96324f6b05b5480b05b4c11fe1a030a69"
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
