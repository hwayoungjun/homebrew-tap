class ClaudeUsageBar < Formula
  desc "Claude Code usage monitor for macOS menu bar"
  homepage "https://github.com/hwayoungjun/claude-usage-bar"
  version "0.6.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.5/claude-usage-bar-darwin-arm64.tar.gz"
      sha256 "768bff3b9d46e9ab9e4906777c2f23cfd65dcad1dc7a04d3131c42a30c34958b"

      def install
        bin.install "claude-usage-bar-darwin-arm64" => "claude-usage-bar"
      end
    end

    on_intel do
      url "https://github.com/hwayoungjun/claude-usage-bar/releases/download/v0.6.5/claude-usage-bar-darwin-amd64.tar.gz"
      sha256 "3154d2617da6ac80862bd48b4e48ea2fbd59f4c392aa3a45bbd4652330be4804"

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
