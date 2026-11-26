# typed: false
# frozen_string_literal: true

class Hbctl < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbctl"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.3/hbctl-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "2fb4b65989e46d217b161ddd8ea23fa393d676ee3bbeafe9cfea9317a1e7addd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.3/hbctl-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "a62eca293a7f0acab9a96c47c065256b02f748c5a3ce2551f2223d1666b7e5ae"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.3/hbctl-0.1.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7b38e3018ef5068e2bbc0bc87b679481976fa65b51ac806da5e6fefbef505cd4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.3/hbctl-0.1.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "039ff99355766f976056fd4dc942bf5b33b9a187eaaabf0325956281f3c9c2fb"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.3/hbctl-0.1.3-arm-unknown-linux-musleabi.tar.gz"
        sha256 "db01f398e70374d0e0c9ff81e1bdebd1134aa9219f88776a4b4e67dd67424c44"
      else
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.3/hbctl-0.1.3-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "8badb4fb0455533b60f9defcaaeb43f592c7e9e5c086aa26c8659b32fc01da0f"
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
