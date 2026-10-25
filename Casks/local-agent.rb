# Written by local-agent's release workflow (scripts/release-cask.ts).
cask "local-agent" do
  version "0.54.2"

  on_macos do
    on_arm do
      sha256 "48db719601bff82f51b4174fb3ae03ba83212008e224a179ec369a7049f0374e"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_arm64.tar.gz"
    end
    on_intel do
      sha256 "939fa8df1852c6ed1d711faaaf57a54f0a7f31e5e9cedb5fd3fedb06c7230968"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_darwin_amd64.tar.gz"
    end
  end
  on_linux do
    on_arm do
      sha256 "3c6936436925c3240e68aa74ca53b9a4f21a6ed0b8e524f40a4b0048e65dafd5"
      url "https://github.com/abdul-hamid-achik/local-agent/releases/download/v#{version}/local-agent_#{version}_linux_arm64.tar.gz"
    end
    on_intel do
      sha256 "bdbf8cef873f4b285b28ab44a5b7d529b51dd2ca4188d55ededb32ab5dd00cfb"
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
