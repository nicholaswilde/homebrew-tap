# typed: false
# frozen_string_literal: true

class Hbx < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbx"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "da60d24e0449570ed2026e8dc71425d1e1b2eaa620683e800d1c389f4f4df8a2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "43dc17e7f7329f350797c17211ae52f373e2d5ecd76ce2176a421262f586b98f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "315928d86c503aa95029ced9affe31e6b429eeac00d74f50827fb5ed93f37c2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "acefefdc253029e1c56d6babba0d8cca4fc96d0ecbe0ccb72f17dfb6e9e23312"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-arm-unknown-linux-musleabi.tar.gz"
        sha256 "30c97205f0149070f8883909a6b6574b56f04a3057067b3ba5561b30aacef00d"
      else
        url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "efaa851ec74ea693285dc82af5e545b15382263d6cab4c1157ddc4fe82baf9ff"
      end
    end
  end

  def install
    bin.install Dir["**/hbx"].first
  end

  test do
    system "#{bin}/hbx", "--help"
  end
end
