# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  version "0.1.18"
  license "Apache-2.0"

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.18/sysmqttd-0.1.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d7498c668d2bd3ec4cde9c809863b6b4c4716eb7422b279c8ee9a124fd040898"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.18/sysmqttd-0.1.18-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bd90ef239fb1f26945fbaf79473833d46b1f66a2a379c367a852aeb75329d4f2"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.18/sysmqttd-0.1.18-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "51f7832795f293c95d7481ca113bad346c0fbf16ac55ce8645bbf21d6fd1a572"
      else
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.18/sysmqttd-0.1.18-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "2a68e5c2761ab2789348b0996ac54ecd25339e5519ca29152c569f57503fdeb0"
      end
    end
  end

  def install
    bin.install Dir["**/sysmqttd"].first
  end

  test do
    system "#{bin}/sysmqttd", "--help"
  end
end
