class Beamup < Formula
  desc "Bidirectional real-time file sync for Teleport Beams"
  homepage "https://github.com/webvictim/beamup"
  license "Apache-2.0"

  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-arm64"
      sha256 "67b79ce41d6f1e3c35ca620210ac8b19ec4c759f8cba930e657752aad8db2b98"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-amd64"
      sha256 "8710855a86cab1ad71d94c5c6e8bd6cce0aabb932a4944739c8365919ad83140"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-arm64"
      sha256 "9ff916de20a0108bf3018627921f3b01bb169c1c646cd46934f6c9f6d1a2acd3"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-amd64"
      sha256 "a2b31cb5ed4ebb1157f3a0c453f6ac6c06e7b61d97e7baf95878f831f8443c8c"
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
