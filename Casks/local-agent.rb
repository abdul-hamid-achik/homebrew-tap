# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.54.1"

  on_macos do
    on_arm do
      sha256 "10fad67d17d115af6f45edc756dac01accb25157e0d5f6745ef0e97a771620e5"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "7ca186601513c54eed1545bc01e40dcf363b12f7f30ef2323ee6902a9e92da98"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "02c138f4d2062f0afaddf236d526d2c4e9632c453931858457025459bca42201"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "20107d8d925ae281a7be2826a0c930c9703d54235b3f7cb16a2d4a65fb0c0fe5"
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
