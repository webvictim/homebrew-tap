class Beamup < Formula
  desc "Bidirectional real-time file sync for Teleport Beams"
  homepage "https://github.com/webvictim/beamup"
  license "Apache-2.0"

  version "0.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-arm64"
      sha256 "70c88428ad7d0d13723f0fe0d684bb96196b81386e3823567fd7173568a4c18d"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-amd64"
      sha256 "a53ebe9a657d8e3d5410c00c0b03a629aa2014e9f2cb03e5056d6556d940902a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-arm64"
      sha256 "6f332e9bd0905d302afd0964edcdec450f4ba6541a1f31fc7bea3b7373a78976"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-amd64"
      sha256 "0af11227bcee3e9f3885468a888a532546e63f292d85c763da997ed914a215b0"
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
