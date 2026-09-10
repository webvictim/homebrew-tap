class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.20.tar.gz"
  sha256 "13cd102580b6357af55343ba1d1806fbdeb18821fb18146eae36229915787d06"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.20: clients that address prism without a /v1 prefix — the
      Vercel AI SDK, so OpenCode and anything built on it — were proxied
      but skipped logging, `prism usage` accounting and Bedrock scrubbing
      entirely. Those requests are now canonicalised, so they show up in
      `prism logs` and `prism usage` and get scrubbed like every other
      client. The request log and its token counts are also one line now,
      with cache counts included:

        POST /v1/messages 200 req=747024B resp=2073B model=claude-opus-5
        in=2 out=89 cache_read=18807 cache_write=209741 2.721s

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
