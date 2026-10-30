class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.27.tar.gz"
  sha256 "007fc60e10f79c1aa4d4ca869f96df604721f10404d27b530a7f50ef5c538f22"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.27: "prism claude" works on a managed machine whose
      settings pin Anthropic sign-ins (forceLoginOrgUUID or
      forceLoginMethod), with no login at all. Such a machine rejects
      every Anthropic credential Claude Code is given, prism's dummy
      gateway token included, so Claude Code refused to start -- and
      dropping the token only moved it to "Not logged in". A pin polices
      first-party sign-in, so prism now runs Claude Code there as a
      third-party platform client pointed at the local router, with no
      credential at all: the shape a Teleport beam uses against the same
      cluster gateway. Nothing to configure.

      Managed settings that say nothing about sign-ins are unaffected.
      "prism config set claude_auth platform" asks for the third-party
      provider outright, for a pin delivered by a route prism cannot
      read.

      This fix needs no daemon restart -- it is all in the launcher.
      Run "prism down && prism up" when you want the daemon itself
      on the new binary.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
