class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.15.tar.gz"
  sha256 "8373ece5d1112a3ce678b21f675f4a073f3fe95274f8eca3469fd933a3d05814"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.15: Forward-proxy mode for Claude Code Remote Control.
      Enable with: prism config set claude_forward_proxy_mode true

      Then restart: prism down && prism up

      This routes model API calls through Teleport while letting Remote
      Control, telemetry, and MCP talk directly to api.anthropic.com.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
