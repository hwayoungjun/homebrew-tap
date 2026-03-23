class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.2.0/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "63d5f559f053b993386894b5ce59a5bbe81d7a8ae0858771a5db6d5ba0af11b1"
    end
  end

  def install
    bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
  end

  def post_install
    system bin/"claude-usage-bar", "setup"
  end

  def caveats
    <<~EOS
      Claude Code statusLine has been configured automatically.

      Launch the widget:

        claude-usage-bar

      Or enable "Launch at Login" from the dropdown menu.
    EOS
  end

  test do
    assert_match "Claude Code usage monitor", shell_output("#{bin}/claude-usage-bar --help")
  end
end
