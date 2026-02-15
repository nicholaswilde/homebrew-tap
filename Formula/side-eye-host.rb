# typed: false
# frozen_string_literal: true

class SideEyeHost < Formula
  desc "USB Stat Monitor for Linux rig"
  homepage "https://github.com/nicholaswilde/side-eye"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.1/side-eye-host-0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "c454d114fa301fc6171f510ac4cd7b6d2250e7fe44cc7e7caf8439c229d9502d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.1/side-eye-host-0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "8d9e9af4db537142ef95d54000f7773472762d9d6fbb710381ded0b22d49a5a2"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.1/side-eye-host-0.2.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d2faac8ad3eee6ae27f17fcc6b0d845d744540e335aecb816a6427f16e988d3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.1/side-eye-host-0.2.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7866aed4a5a1e6b6e99d62a391c78a127ce1d5e1673576a7e44a54ff0a1bdfd5"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.1/side-eye-host-0.2.1-armv7-unknown-linux-musleabihf.tar.gz"
      sha256 "86624acd186fc1d60832d7aeba265eb9d10236acecca36924ac0dae7b56fe135"
    end
  end

  def install
    bin.install Dir["**/side-eye-host"].first
  end

  test do
    system "#{bin}/side-eye-host", "--help"
  end
end
