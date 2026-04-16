class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.6.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.2/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "fe3c9356b2e778e1a9db9330bbdf398dbb9ed7bab171526dea7aba94fa580f36"

      def install
        bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
      end
    end

    on_intel do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.2/claude-usage-bar-darwin-amd64.tar.gz"
      sha256 "d61f4a2db472824607f0e491ec9fc2c43a301c66e86c3b244a7530a4cc9f061c"

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
