# typed: false
# frozen_string_literal: true

class Hbx < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbx"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-arm-unknown-linux-musleabi.tar.gz"
        sha256 "0000000000000000000000000000000000000000000000000000000000000000"
      else
        url "https://github.com/nicholaswilde/hbx/releases/download/v0.1.0/hbx-0.1.0-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "0000000000000000000000000000000000000000000000000000000000000000"
      end
    end
  end

  def install
    bin.install Dir["**/hbx"].first
  end

  test do
    system "#{bin}/hbx", "--help"
  end
end
