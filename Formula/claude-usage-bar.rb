class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.6.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.4/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "ced39dea763038da30d6c01c37a9842b94e0365bd5c394135f1afa0d4926192b"

      def install
        bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
      end
    end

    on_intel do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.4/claude-usage-bar-darwin-amd64.tar.gz"
      sha256 "e81064e50403342a1c3fe0fb44a8c75755250801f276d34d56640044061e48d3"

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
