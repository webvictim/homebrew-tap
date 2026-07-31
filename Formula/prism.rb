class Prism < Formula
  desc "Route local AI traffic through Teleport-managed LLM gateways"
  homepage "https://github.com/webvictim/prism"
  url "https://github.com/webvictim/prism/archive/refs/tags/v0.1.14.tar.gz"
  sha256 "f4bb1baef5c3ac3901cb302a314b4a147c6a88af0f4c712dade8572a782578e5"
  license "Apache-2.0"
  head "https://github.com/webvictim/prism.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"prism"), "./cmd/prism"
  end

  def caveats
    <<~EOS
      If upgrading from a version prior to 0.1.14 with tbot configured,
      run `prism down && prism up` to pick up the new renewal interval.

      Teleport caps bot certificates at 12 hours. Previous versions
      requested 24h certificates with a 23h renewal, causing expiry
      before renewal. The new defaults (12h cert, 8h renewal) fix this.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prism version")
  end
end
