class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.6.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.3/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "4b45f0d95de9785677f85545b4c835af9ad7d4255bec990906d745c4a9aef904"

      def install
        bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
      end
    end

    on_intel do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.3/claude-usage-bar-darwin-amd64.tar.gz"
      sha256 "c685d6cdd1dda8d0ea447cdfa9804ebd5eeb5f2f94e1e9c42763331a8a7eeee9"

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
