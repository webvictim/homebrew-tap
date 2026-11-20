class Beamup < Formula
  desc "Bidirectional real-time file sync for Teleport Beams"
  homepage "https://github.com/webvictim/beamup"
  license "Apache-2.0"

  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-arm64"
      sha256 "a31309fcefdc00e3a61eaed525cc0e7b0e7a399abed5fb481c3377bcba146c72"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-amd64"
      sha256 "fd8199d903163b4ef596ddd3b59061833b6d60baaf9a7db1b18c8039c9f36f8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-arm64"
      sha256 "1142939d0b5221dc7ccf00715c90c6a38a89c586f163939d5b40f7a0a48c7502"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-amd64"
      sha256 "fdefb3a6f3336aa0d8d57579bd8ee155dba6df4c2a4b7174e5b50d4f304528ff"
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
