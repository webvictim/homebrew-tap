class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.25.tar.gz"
  sha256 "7d11eeade788525dfec8422d7150a97ccd6c29383ecbb2905f7720817b981761"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.25: you no longer need a Claude subscription to use
      "prism claude". Sessions on a machine that had never logged in —
      or whose claude.ai login had lapsed or been cancelled — stopped at
      "Not logged in . Please run /login", even though prism needs no
      Anthropic credential: the Teleport LLM app authenticates
      cluster-side. prism now supplies a dummy gateway token, so install
      and go. A working claude.ai login in forward-proxy mode is left
      alone, since Remote Control needs it; "prism config set
      claude_auth token" forces the token if a stale login still looks
      usable.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
