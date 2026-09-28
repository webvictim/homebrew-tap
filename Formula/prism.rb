class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.23.tar.gz"
  sha256 "4da8f45354b9c431be1fee57456c47de93866d84713e0ab485a21354c4d32108"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.23: fixes auto mode refusing every command in newer Claude
      Code builds ("The server-side auto mode classifier gave no verdict").
      Claude Code now asks the API to run that check server-side and the
      gateway never answers, so `prism claude` and `prism env` set
      CLAUDE_CODE_AUTO_MODE_SERVER=0 to keep it local. Your own value for
      that variable is respected. Also carries 0.1.22's fix for
      `tool type 'advisor_...' is not supported for this model`.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
