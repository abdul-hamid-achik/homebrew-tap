# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.52.2"

  on_macos do
    on_arm do
      sha256 "c3e044aba467ce0acf7872040614123fb5dac947b6123fb174381342f7c15a49"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "6b552848f23594339575329df88a68c9c297ede2ea92f5ae407cfa42fe82d196"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "2c8c66279b47d2840b2e194f23b3301ed8898f1042b1f31129e485f54daaa3b9"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "9c71698a3c643732da57ba2f2bbfdbddf3d77442bb232f6970e86f93f545289d"
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
