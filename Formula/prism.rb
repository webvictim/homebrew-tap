class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.28.tar.gz"
  sha256 "47b2fae993b79406a1040be18d501d1b8ac1612cf04a86fc49e610aaa52be446"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.28: prism tells you when the cluster gateway served a
      different model than you asked for. The Teleport LLM app serves
      only the models its cluster is configured for, and quietly
      substitutes a fallback for anything else -- the request succeeds,
      nothing in the response mentions it, and your client keeps
      reporting (and pricing) the model it asked for. Claude Code's own
      default, claude-opus-5-5, is missing from some clusters' lists.

      A substituted call now shows up as
      "requested=claude-opus-5-5 model=claude-sonnet-5 [!]" in the
      request log, is counted per pair by "prism usage", and is
      mentioned once at "prism claude" launch when it happened in the
      last 24 hours. To learn what your cluster does serve, ask for a
      model and read the reply's own "model" field back: a name that
      returns unchanged is served, anything else is the fallback.

      Restart the daemon for this one -- run "prism down && prism up".
      The "[!]" marker and the "requested=" field are produced by the
      daemon, so an upgrade alone will not start logging them. The
      "prism usage" section and the launch-time line work immediately.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
