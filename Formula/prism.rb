class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "bbf148439353cfd4f446a70688389b74062a696441059d6476c4c4da52301dfb"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.2.1: prism tells Teleport which cluster it means, every
      time. tsh and tctl act on whichever profile your shell last
      logged into, which is not necessarily the cluster prism is
      configured for. prism now passes "--proxy" to tsh and
      "--auth-server" to tctl on every call, so you never have to
      change your login context to run a prism command.

      This mattered most in "prism tbot reset": logged into another
      cluster, it would have created this machine's bot, role and
      token there, and the only symptom would have been tbot failing
      to join at the last step. Its preflight now asks whether you
      have a live login to prism's own cluster, and names the exact
      "tsh login --proxy=..." to run if not.

      prism's configured proxy is the authority for which cluster a
      machine belongs to, so moving a machine to a different cluster
      is "prism config set proxy <host:port>" followed by
      "prism tbot reset". Reset says when it is moving a machine
      rather than repairing one, and leaves the old cluster's
      resources alone.

      From 0.2.0, if you have not upgraded yet: "prism doctor" checks
      everything and prints one report with the fix on each line, and
      "prism tbot reset" rebuilds a broken Machine ID identity from
      scratch. prism also refuses to start tbot on an identity copied
      from another machine, which a Mac cloned with Migration
      Assistant brings along.

      Restart the daemon for this one -- run "prism down && prism up".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
