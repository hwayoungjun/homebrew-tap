class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.5.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.5.0/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "8a5935d16dc8939bd10b4b43e02a875ebbb4d373f956920dfa2b4e49ba7f5848"

      def install
        bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
      end
    end

    on_intel do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.5.0/claude-usage-bar-darwin-amd64.tar.gz"
      sha256 "b6329cc7dc2a9a14e51d66347caec7ec6d98ceb0dff8749a22669e88bd2905b2"

      def install
        bin.install "claude-usage-bar-darwin-amd64" => "claude-usage-bar"
      end
    end
  end

  def post_install
    system bin/"claude-usage-bar", "setup"
  end

  service do
    run [opt_bin/"claude-usage-bar", "--foreground"]
    keep_alive false
    run_type :immediate
    process_type :interactive
  end

  def uninstall_preflight
    system bin/"claude-usage-bar", "uninstall"
  end

  def caveats
    <<~EOS
      Claude Code statusLine and VS Code processWrapper have been configured automatically.

      Start the widget:

        brew services start claude-usage-bar

      Or launch manually:

        claude-usage-bar
    EOS
  end

  test do
    assert_match "Claude Code usage monitor", shell_output("#{bin}/claude-usage-bar --help")
  end
end
