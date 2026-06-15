class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "c276501071839b75b44d72c7af2edc12ec9f1890d0fe5bd50de73fe3a7bdd85f"
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
