class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "84dd09031a08d5d9c31ed715ac88c0bd41a249265bfb6259faf60f19f505e4e6"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.2.2: "prism tbot reset" fixes a locked bot. When
      Teleport sees a Machine ID identity renewed out of order, it
      assumes a stolen certificate and locks the bot's join token
      ("... locked due to a certificate generation mismatch"). Reset
      recreates the token under the same name, so it used to fail on
      that lock at its last step; it now removes the lock as part of
      the rebuild. A lock someone placed by hand is never removed.

      Nothing has to have been copied for that to happen: a renewal
      whose reply was lost while a laptop slept is enough, and so is
      a tbot left running by a crashed daemon. prism now stops such a
      leftover tbot before starting its own.

      "prism doctor" reports your tbot's version against the
      cluster's, and says when the running tbot isn't the installed
      one. Kimi K2.5, GLM 5 and the GPT models all work from
      /v1/chat/completions at once. The test requests in "prism test",
      "prism doctor" and "prism tbot reset" now name claude-sonnet-5
      by default; "prism config set anthropic_test_model <id>"
      changes it without a new release.

      From 0.2.1, if you have not upgraded yet: prism passes the
      cluster to every tsh and tctl call, so nothing depends on which
      profile your shell last logged into.

      Restart the daemon for this one -- run "prism down && prism up".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
