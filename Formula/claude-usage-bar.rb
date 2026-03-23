class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.1.0/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "de44183ba94a682f0bba98a53dab677845958eb39df632467c82043485697a9b"
    end
  end

  def install
    bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
  end

  def caveats
    <<~EOS
      Run setup and launch:

        claude-usage-bar setup
        claude-usage-bar

      Auto-start on login:

        brew services start claude-usage-bar
    EOS
  end

  service do
    run [opt_bin/"claude-usage-bar"]
    keep_alive true
    log_path var/"log/claude-usage-bar.log"
  end

  test do
    assert_match "Claude Code usage monitor", shell_output("#{bin}/claude-usage-bar --help")
  end
end
