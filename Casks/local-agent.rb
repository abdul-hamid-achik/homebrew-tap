# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.53.2"

  on_macos do
    on_arm do
      sha256 "58b5a8d9651e2d7483145a3a72d2463696b0d282ce4a36af015d7e750db3e1e6"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "f5b7b73f5d7036a1bcbcdf3d221f3cd74411fb835b239ca6750e025e6250dcb4"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "842d29fbce11b82f09b83fb24137ca25504bc6a64d2e7a79ced1cc99db2c0dad"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "6c025fd75df0cc951a03d7920372345591742d4a403c66a7312274fa74619182"
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
