# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  version "0.1.12"
  license "Apache-2.0"

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.12/sysmqttd-0.1.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "08ebf3698cb270da3839d42d83d8239cdcdcb806d903c223664ff30730027f6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.12/sysmqttd-0.1.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f4261f2dad739beef09394a8287853fbf27f1225118f46d8e4c452ba742d7ff6"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.12/sysmqttd-0.1.12-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "f58d7928e43c0bbc615ded04a96b1cb3f15e6c7089bfbd276ec45536a0b1960f"
    end
  end

  def install
    bin.install Dir["**/sysmqttd"].first
  end

  test do
    system "#{bin}/sysmqttd", "--help"
  end
end
