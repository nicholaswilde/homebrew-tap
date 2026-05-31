# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  url "https://github.com/nicholaswilde/sysmqttd/archive/refs/tags/v0.1.22.tar.gz"
  sha256 "b67b895439fd941d8e05ab7fa93c7c4f6609be22f97279a42badaa399a819930"
  license "Apache-2.0"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.22/sysmqttd-0.1.22-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4f2ece3de9a5ff39d2551fd10c1fc77fc088aa10c29fc536611e6b8bbde6a23f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.22/sysmqttd-0.1.22-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a4682f8eb87fb08b3105854e59096038e482c4b3069ac799d757599fe3d3ce90"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.22/sysmqttd-0.1.22-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "33369635cdd1a543c9ce1f62082b26e539a68d6479a121f9b0886be949d0826d"
      else
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.22/sysmqttd-0.1.22-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "0896031e85e88d23c828501bb09b87b1a22377de5add639922480b380b89392f"
      end
    end
  end

  def install
    bin.install Dir["**/sysmqttd"].first
  end

  test do
    system bin/"sysmqttd", "--help"
  end
end
