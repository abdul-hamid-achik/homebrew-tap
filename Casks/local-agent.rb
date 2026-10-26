# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.54.3"

  on_macos do
    on_arm do
      sha256 "3def34b81defbd421715b9a283bc4fb4cb836cf4efd4d3764da3dda3dc68f539"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "794c9e7abcec5c2781ff19d3e3f710b068fad93c48798a7eaca89a5423a0e092"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "281a00f6858cdcaed1428eec804c41942955c32190df15a9ae1c8a8470374a94"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "07cf6044baba5ac8086391b014f40646c7d271036e9427f4c224324adfa1dcae"
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
