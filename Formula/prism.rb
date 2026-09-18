class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.21.tar.gz"
  sha256 "0ba5ade32087b2eabc617c531e407a3d18b603445db5a9e2e22f29ad170ae8c2"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.21: `prism pi` and `prism opencode` are now first-class
      launchers, like `prism claude`. `prism pi` bootstraps a fresh Pi
      install, rewrites only the model entries it manages — custom
      providers such as llama-swap are left alone — and honors
      PI_CODING_AGENT_DIR. Pi's Anthropic models no longer fail with
      `fallbacks: Extra inputs are not permitted`.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
