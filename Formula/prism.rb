class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.16.tar.gz"
  sha256 "a12556dda3fd3af0fb189ef8ad208428771e9f143add704f39d7b96e1d87e7ef"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.16: headless `prism claude rc` now works in
      forward-proxy mode (Claude Code Remote Control).
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
