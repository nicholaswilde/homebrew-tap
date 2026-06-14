# typed: false
# frozen_string_literal: true

class Sysmqttd < Formula
  desc "System monitoring & GPIO actuation daemon in Rust with MQTT autodiscovery"
  homepage "https://github.com/nicholaswilde/sysmqttd"
  url "https://github.com/nicholaswilde/sysmqttd/archive/refs/tags/v0.1.23.tar.gz"
  sha256 "eeeecdc4584b636065859acf05133732275e84c01d3ca6ea53c4b66be8536842"
  license "Apache-2.0"

  depends_on :linux

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.23/sysmqttd-0.1.23-aarch64-unknown-linux-musl.tar.gz"
      sha256 "1149ca45af61f651b228fadea05080ac7751fd5d455099d481c7c44b3171788b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.23/sysmqttd-0.1.23-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2c64e943d1dcfe193f1167d752e8e8bfe737e2135a3ff90b43a117c606c65c12"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.23/sysmqttd-0.1.23-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "739237138fb35a78fc585e6a04b65f4a97597a25e08ed6b8565a2e647b942575"
      else
        url "https://github.com/nicholaswilde/sysmqttd/releases/download/v0.1.23/sysmqttd-0.1.23-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "5233cd8ec39d9f09ce501392d0f99a20d75b3ae514984ef237336ef0a1e3f3f7"
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
