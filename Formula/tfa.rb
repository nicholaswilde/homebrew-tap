# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.5/tfa-0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "9f8c299e0d50dc55c96ad3c8698325e1704ea638ecf682527be191e266624a61"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.5/tfa-0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "b6eed86a3cbf38aaa2e3f86f24ed5bfd83d36d8783225cb366c6f6513313439d"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.5/tfa-0.1.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "79473a5ea334733e5c3a78cdeba3162c56b9de7c5ee7eb7113667e840965fbef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.5/tfa-0.1.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bf2275e3b52e65e4a64e398c16c2e4c02fb4444cf3769ff4a77c8b8a41243f13"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.5/tfa-0.1.5-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "d320c5b3d9cfb96a8cf52cf4915638aea370ac8c17401852c560e5a07de6ea6e"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.5/tfa-0.1.5-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "3c6ce4a5248961e850fd66e62938e395009ce8cffcfcdc06f58985207aa2925e"
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
