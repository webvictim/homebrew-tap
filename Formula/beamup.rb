class Beamup < Formula
  desc "Bidirectional real-time file sync for Teleport Beams"
  homepage "https://github.com/webvictim/beamup"
  license "Apache-2.0"

  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-arm64"
      sha256 "3e2e8b40712f811371432d73a2bf5cc87695021428fa2086d4547be71f9e8a6d"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-amd64"
      sha256 "6d8961f0c7f3cb352ed4a87f249e04bea6afc5250ac45635c02d7d08b33f1caa"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-arm64"
      sha256 "7efb13d09f037295586fe8df6ac3c5f28aa5da5a6e385a86a7cc1fd3bb0b5db9"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-amd64"
      sha256 "1dffafa6d10a76da439196f38f47d5310fab2cecb74e2dd8967d1db45e22f774"
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
