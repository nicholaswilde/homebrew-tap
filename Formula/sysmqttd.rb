# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  version "0.1.8"
  license "Apache-2.0"

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.8/sysmqttd-0.1.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0e3df66cda4172d514ccd6cb5d9ad72e49e13f7723d2ee36bc82ad996b2e9199"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.8/sysmqttd-0.1.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "978409848f97f637deba3117ae56f4f98fd189415663f2304db4dc4463c3b12c"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.8/sysmqttd-0.1.8-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "9509b039af56532f690a91434b13af4a2f7af9404f2fd0c98a6779af43b3ae91"
    end
  end

  def install
    bin.install Dir["**/sysmqttd"].first
  end

  test do
    system "#{bin}/sysmqttd", "--help"
  end
end
