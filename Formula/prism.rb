class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.22.tar.gz"
  sha256 "6bdfab0d97940d39fdb7957af61f9a2929876b8482856095dc3c81d413a914d0"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.22: fixes `API Error: 400 ... tool type 'advisor_...' is
      not supported for this model`, which broke every Claude Code request
      after its latest update — prism now drops Claude Code's unsupported
      advisor tool. New anthropic_strip_fields / anthropic_strip_tool_types
      / openai_strip_fields / openai_strip_tool_types config lists let you
      drop the next gateway-rejected field or tool yourself, without
      waiting for a prism release.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
