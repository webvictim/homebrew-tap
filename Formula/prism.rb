class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.26.tar.gz"
  sha256 "c25819ee50287c6811f5ed3103107f755229e91663131ee48c62c2411d3ab1ed"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.26: "prism codex" works again. Codex does not honour
      OPENAI_BASE_URL, so every session went straight to OpenAI with the
      dummy key prism hands out and failed with "Incorrect API key
      provided: teleport"; on 0.165 it failed twice, first on a
      WebSocket to api.openai.com and then on the HTTPS fallback to the
      same host. prism now registers a provider pointing at the local
      router on Codex's own command line, with WebSockets disabled, so
      there is nothing to configure. Tested against Codex 0.145, 0.155,
      0.164 and 0.165.

      A bare "codex" still needs that provider in ~/.codex/config.toml;
      the README has the block to paste.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
