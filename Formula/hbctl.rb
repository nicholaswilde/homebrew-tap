# typed: false
# frozen_string_literal: true

class Hbctl < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbctl"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.5/hbctl-0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "d43cb69fbdd97ff15104497ad2293d7f90769c9099da66f32407a6f2271c9f22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.5/hbctl-0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "0fe9e1de51bbb43809de6a1623c27f204bb3e37365a4a72ed82b7522957f919c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.5/hbctl-0.1.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fa25ea15240bdcaa459993dd3dfe9049d02ea2a0a6bbde8f59227cc9edac4222"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.5/hbctl-0.1.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f381db01ef95f781cbe642768a231050c387cc277b0c7add9ff3ff535809f6de"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.5/hbctl-0.1.5-arm-unknown-linux-musleabi.tar.gz"
        sha256 "b0acc809259a57012142bf754937f04ee0467f4e8a19e9057517cf5f7a81b9d7"
      else
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.5/hbctl-0.1.5-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "72e57d15408e5767c067a3c014d9bde506d1a95d16c8d60c15d13b01ecb3c864"
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
