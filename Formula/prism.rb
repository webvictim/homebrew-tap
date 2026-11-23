class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "a48fd486836183db67168c492ecf496ed9dd4e079a67a160547919fe753afcca"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.5.0: the tenant's token quota in "prism usage",
      "prism status" and "prism doctor", read with your tsh login.

      If Claude Code's status line is statusline
      (ryanclark/tap/statusline), "prism claude" shows the quota there
      too. "(tsh login expired)" or "(stale)" means run "tsh login"
      again. "prism setup statusline --remove" undoes it.

      Run "prism down && prism up" so the daemon starts reading it.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
