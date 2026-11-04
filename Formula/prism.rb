class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "932d247b1062b805008c6d987acfda76695132b641259bbe71910da1894b5645"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.3.0: "prism models" shows which models your cluster
      serves, and "prism codex" now offers only those in Codex's
      /model picker ("prism config set model_discovery false" turns
      that off). The daemon keeps a copy of the list, refreshed hourly;
      on a tbot machine it reads it with a short-lived tbot identity,
      so no tsh login is needed. Reading the list needs tsh 18.8.3+.

      "prism test" picks its test models from that list, so it passes
      on a gateway with no default model.

      For scripts and apps that wrap prism: "prism status --json",
      PRISM_QUIET=1 to keep prism off stdout, and PRISM_CLAUDE_BIN
      (and _CODEX_, _OPENCODE_, _PI_) to run a tool from a set path.

      "prism claude" and "prism env" no longer print a model-swap
      warning at startup; "prism usage" still lists swaps.

      Restart the daemon for this one -- run "prism down && prism up".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
