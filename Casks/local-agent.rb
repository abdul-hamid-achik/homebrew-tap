# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.53.0"

  on_macos do
    on_arm do
      sha256 "b8c0bcd66bf741a294cc119c589b47eed18d94dc43a8304cf867cac5b6cd0a34"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "b0f1c9e4ef80339413ef19240e90f42376bac0b93651e80bce8af746dcea775b"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "7de1e40db53f795443234c8819972b708ceba879cccebf36e3c009656b38d28f"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "dd6b775546ee2733cda7b22e7583093d97b79d77bada543bee3ea27027edc1bd"
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
