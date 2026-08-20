class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.18.tar.gz"
  sha256 "62d3488d6d3cae26ad2633b71fda0635d8b6b1629638548e4898cc95a72abb4f"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.1.18: forward-proxy mode now logs requests to `prism logs`,
      tracks token usage, and auto-refreshes expired leaf certs after
      laptop wake.

      Restart after upgrade: prism down && prism up
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
