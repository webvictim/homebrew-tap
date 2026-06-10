class Beamup < Formula
  desc "Bidirectional real-time file sync for Teleport Beams"
  homepage "https://github.com/webvictim/beamup"
  license "MIT"

  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-arm64"
      sha256 "3a5a51ccbd89891be48dc407b4953ee5c1bf0d4774c9bef39f06060262c79692"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-darwin-amd64"
      sha256 "75e6da5e6687f61e92d977e0be62e7e176c68d3e18bfb23954b5acfeb2c5181a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-arm64"
      sha256 "3dc44a85a1d3ebc9dc24f16da9f3946ac00d711985357de2edff30dc62f51b20"
    else
      url "https://github.com/webvictim/beamup/releases/download/v#{version}/beamup-linux-amd64"
      sha256 "10a644e868b8a6213b1012569fe27bdb8374209131a8e54322a8ad9ce2d2680e"
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
