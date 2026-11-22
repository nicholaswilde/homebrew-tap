# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.16/enstow-0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "ba63168cb956924fc2b3e9c87e76e352377f8702dafe3b1a981e7ce3b1d12cb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.16/enstow-0.1.16-x86_64-apple-darwin.tar.gz"
      sha256 "c974d4da29afc973b38371d0fdbcea6d6ab0df1f7142498d492fede6e91a400a"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.16/enstow-0.1.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "64e03fa8574afce8b75702db158f1101f107d1f62859ad645adf703e7f86b970"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.16/enstow-0.1.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2e37209c115b5a8d7405c3ff02e6b4b545e2c37687b39565b01c51260b0bf2fc"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.16/enstow-0.1.16-arm-unknown-linux-musleabi.tar.gz"
        sha256 "d2236227da5905d1d1575bc70ed53ab67ee7886b43364c379f135a29d5d392d9"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.16/enstow-0.1.16-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "a5c5813637eb8c0f048e36f59ff10db84008c306e8ab680a511fdd3d297934fa"
      end
    end
  end

  def install
    bin.install Dir["**/enstow"].first
  end

  test do
    system "#{bin}/enstow", "--help"
  end
end
