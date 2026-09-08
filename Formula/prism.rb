class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.19.tar.gz"
  sha256 "f5f50e005898b306df9a060104d9724177f716cbeedfb4cddce69c9c83149394"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.19: OpenAI-compatible clients that only speak
      /v1/chat/completions (MacWhisper, session summaries) work again —
      prism translates those requests to the Responses API, which is the
      only route newer gateways serve OpenAI models on. Disable with
      `prism config set openai_chat_completions_shim false` for older
      gateways. `prism test` gains --format/--model/--stream, and
      `prism pi config` now mirrors Pi's own model catalog.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
