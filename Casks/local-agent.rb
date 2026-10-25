# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.52.0"

  on_macos do
    on_arm do
      sha256 "99f7c681a7f1c6eb81dfe843f735922863676ff3caed852cd05c7bea9b14e41b"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "bc470942373a830e87b9af66df20c9ed3c1be3033de77857b065f8d442fee538"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "fff7ef720a83a1a6f3ff5f90084e0becee08f056a2886d1f4747ff48cd8289ab"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "27cb8375b255ca805f1a797fdcac7d6c73a602d46ce3a1cb9aab3ffb46ec0336"
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
