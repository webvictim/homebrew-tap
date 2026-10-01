class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.24.tar.gz"
  sha256 "843a80fd1d9b8910154a7f6bdface37fd4b5a2604d293f05394c8b1f222de24a"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.24: requests a client cancels itself — Claude Code
      dropping a stale or speculative call — are no longer logged as
      gateway failures. They were reported as "upstream error ... context
      canceled" with a 502, which sent people chasing tunnel problems
      that weren't there. Cancels now log a distinct "client canceled"
      line and answer 499; real upstream failures still 502.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
