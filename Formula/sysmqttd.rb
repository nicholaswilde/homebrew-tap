# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  version "0.1.17"
  license "Apache-2.0"

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.17/sysmqttd-0.1.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6ef69d3014e46b329512e9b7855f92f4ef6ca57e2be6f9cb984afb4fc8c3fe32"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.17/sysmqttd-0.1.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "92a7c8990e014d2832787bc8c466c41ab97a14858997adc4fb37b643e64bfc0d"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.17/sysmqttd-0.1.17-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "66d4b48fcbe8e2367d652d696b57aebb33897e30d9b9cda8cc28547f60347741"
    end
  end

  def install
    bin.install Dir["**/sysmqttd"].first
  end

  test do
    system "#{bin}/sysmqttd", "--help"
  end
end
