# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.55.0"

  on_macos do
    on_arm do
      sha256 "eba0c48acac41b19532b688bba13308c03e028c3694c5a2c504ec64b4a4b1d89"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "070e008500ba47c4a25e2f5f5992703a56f5da52b3c4a1b090125d6144ace78e"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "c5cf1de37aa93d2800395029abd46e94d8c82cf13e7499ed03f413bbc9740167"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "01d43ffeef2aa70be0f48b19767f588b9e9b72f74001f7fd72714b5c2601add5"
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
