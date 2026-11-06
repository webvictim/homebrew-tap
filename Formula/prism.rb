class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "c9ee8e10170d0f41669a5314d8a435f56f4e3d29d0a3ac89f6f47bfc660e940a"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.4.0: OpenCode works through prism again. Run
      "prism setup opencode" (and "prism setup pi" for Pi) to add a
      "<model> via prism" entry for every model your cluster serves;
      "prism opencode" and "prism pi" keep them current on launch.
      --overwrite replaces the file's providers with prism's only.

      "prism pi config" is now "prism setup pi". The old name still
      works for now, with a notice.

      Kimi and GLM can now run tools, and Pi's GPT models work.

      Restart the daemon for this one -- run "prism down && prism up".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
