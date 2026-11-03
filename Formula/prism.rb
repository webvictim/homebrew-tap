class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9869f235c93c304904f239e049177f84991db0de2414bb80885b4febc6012403"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.2.0: two commands for when prism stops working.

      "prism doctor" checks everything -- the service definition, the
      daemon and its router, your Teleport login or the whole tbot
      chain, and finally a real request through the router -- and
      prints one report with the fix on each line. It exits non-zero
      if anything failed, changes nothing, and never prints your
      registration secret. It is meant to be pasted to whoever is
      helping you. "prism status" now points at it when something it
      shows is unhealthy.

      "prism tbot reset" rebuilds this machine's Machine ID identity
      from scratch: delete and recreate its bot, role and token in the
      cluster, clear the local tbot state, restart prism, and send one
      request to prove it works. Everything is scoped to this
      machine's hostname, so no other machine is affected. Use
      "--dry-run" to see the plan first; it needs tctl and a live
      "tsh login".

      prism also now notices when its tbot identity was copied from
      another machine -- a Mac cloned with Migration Assistant brings
      one along, and two machines renewing one bound keypair can lock
      the bot and break prism on the original. It refuses to start tbot
      on an identity that is not this machine's and points at
      "prism tbot reset". The binding is recorded the first time a
      machine runs 0.2.0, so a clone is only caught if the machine it
      came from had run this version at least once.

      Also fixed: "prism down --help" used to stop the daemon and
      "prism uninstall --help" used to remove the service.

      Restart the daemon for this one -- run "prism down && prism up".
      The clone check runs inside the daemon, and the service
      definition it rewrites to an upgrade-proof path is repaired on
      the next "prism up".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
