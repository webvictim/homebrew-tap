class Beamup < Formula
  desc "Bidirectional real-time file sync for Teleport Beams"
  homepage "https://github.com/webvictim/beamup"
  license "Apache-2.0"

  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-arm64"
      sha256 "b0a7c398ef6538a9713ca659b1b6c251e49e27cfe79313393ded71efbdaed153"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-amd64"
      sha256 "8350543f89de60d518ad4156f95f66953b76075494b06ae7c98163ed7d7c769d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-arm64"
      sha256 "9f33b02be14f091defc9ccca6dfc3685850d3b0ec9554f0141e5540012fb02e4"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-amd64"
      sha256 "6913c4718c0611c8073191e985f3cf50bceb9b9ca11e8632d85e20312883a75e"
    end
  end

  def install
    binary = Dir["beamup-*"].first || "beamup"
    bin.install binary => "beamup"
  end

  test do
    assert_match "beamup", shell_output("#{bin}/beamup --help")
  end
end
