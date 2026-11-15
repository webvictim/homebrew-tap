class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "7f43d27083bea5985c6fe54001b7987e0d3e8eca38b1cc91afa0ee0725d5e884"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      New in 0.4.1: if "prism models" shows no models, it now says why.
      Usually Teleport's managed updates are running an old tsh (before
      18.8.3) in place of the one you installed; "prism doctor" names
      both and the fix, which is normally "tsh login" again.

      "prism claude -p" run from a script no longer puts prism's
      platform-client note ahead of Claude Code's own errors.

      No daemon restart needed.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
