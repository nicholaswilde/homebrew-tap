# typed: false
# frozen_string_literal: true

class Hbctl < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbctl"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.2/hbctl-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "87631017298e3ec0b755a9f3a0e66a028fc67539783df53d3089a87e48e631ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.2/hbctl-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "5ddc93b8d9bbd238d1d67cbda4de83788bf2b6e77e6986613f6da65ca3db511f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.2/hbctl-0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7a6dfe163c6a4ce6a7efd4e4048070cd2d8efb4d01c9beaf2d73fe584cd16e0b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.2/hbctl-0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f132ee558857c70cf668c28391eb62863d3664522d65280c2913a617460ba22b"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.2/hbctl-0.1.2-arm-unknown-linux-musleabi.tar.gz"
        sha256 "17ecafc9757d723c1fe0d9951799873e4d02ca20320e2ce12336feb239a4252e"
      else
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.2/hbctl-0.1.2-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "5475e076b78ab57415b4769c0115c9d8267f99e7bee3164373efe6eff1b9125d"
      end
    end
  end

  def install
    bin.install Dir["**/hbctl"].first
  end

  test do
    system "#{bin}/hbctl", "--help"
  end
end
