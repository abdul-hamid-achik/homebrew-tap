# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.52.1"

  on_macos do
    on_arm do
      sha256 "4d15da882e7792ec38ea9551aeb00e10f717a9a1b6009c0247325c50fa1c320c"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "1d293d99cdb815f965f20d7585ffb0ef13fd0e76d49717d9abf913abc8d7f67b"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "8149a40bbe3071a04b2df92cba434a4d2b507c86281a68dc8081a6cb56dd8799"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "9f59835c173129a4c0ba7fa672e14fe92ecf373129d61cd422ab4a25128cacc1"
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
