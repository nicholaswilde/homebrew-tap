# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.1/tfa-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "6af82ea87eed5d9d1a7d4566d49ff0e92e2ab8ac87509103b201d4db33e3735a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.1/tfa-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "d45d16cf65ce53613f14cf91e4d837f76ba49f851802239ed6bebc8561d1646e"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.1/tfa-0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "84b4a1cc9cd2d66b3090c9c6bf7fea0f53617727335f6d7d1e6ad60d559c72f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.1/tfa-0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9a138e3498ae95ca1d1ec222d24f7fa397a97b33a55f90008c900c69b6ea30c4"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.1/tfa-0.1.1-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "0e5b12c8f86dbbb973be6de0bf5ee2740e6e004cc8dee65c7b394f2b68845c01"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.1/tfa-0.1.1-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "2f89b8560c2c7df83be18a54d39707df90ab0e87df0eefdaa424ba102772109c"
      end
    end
  end

  def install
    bin.install Dir["**/tfa"].first
  end

  test do
    system "#{bin}/tfa", "--help"
  end
end
