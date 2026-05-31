# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  url "https://github.com/nicholaswilde/sysmqttd/archive/refs/tags/v0.1.21.tar.gz"
  sha256 "c4a1190f54e39f63755b3b5277c3281576fe277d47754233ade6e11e2ac06f7c"
  license "Apache-2.0"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.21/sysmqttd-0.1.21-aarch64-unknown-linux-musl.tar.gz"
      sha256 "4e2c5d00a41070841d0f7cefb8e05b1e01f6781d28f577644d7712f79f401ccd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.21/sysmqttd-0.1.21-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7fb2fc9c95c79b72348432c81ff5a764416d20c199021c9bd01c0731a77883d2"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.21/sysmqttd-0.1.21-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "5f9820805d182013cf180efeb85b619480a89b113fcf851205f6e42ac9c8f7d7"
      else
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.21/sysmqttd-0.1.21-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "41858942b7aedd35ae35e3d9d26ad2363c2e20afd9284ccc6c7a36a7a7bd0295"
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
