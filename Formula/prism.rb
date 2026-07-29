class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.13.tar.gz"
  sha256 "099c9cfdacc8c0e8cef529a896b6d5668f33fdf951a89bbd7be9501d84f504eb"
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
