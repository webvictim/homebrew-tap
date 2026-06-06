class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "e79db80f8dac2cb997bc5b8d899f484fae5cf66594b2d2391d180ccf0c1a114b"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
