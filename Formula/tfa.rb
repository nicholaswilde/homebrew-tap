# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.14/tfa-0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "d848861c850aaa8a93f00f14f86046688f61494f801c3b5f6f2776df2445a878"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.14/tfa-0.1.14-x86_64-apple-darwin.tar.gz"
      sha256 "b1686050ac6096d1054542133861cce22da156d727f5ff4d803a21be7662429f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.14/tfa-0.1.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c02155f90fefdd34faadd4c481857b6fd4d1f57e372309fd69dbc796945c4bda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.14/tfa-0.1.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3c5f1466b3b1896e35f6b0b293f535804a1cbe64f6f92cb0b2342a8118ca2360"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.14/tfa-0.1.14-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "a5144db32986427659959246c080fcc0eed77a859af1d23ea051fa4635c0054a"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.14/tfa-0.1.14-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "7cde797843b8e5b4ee7d7411fac3ba0ef07cf6027430eafe13383a896d1b53ef"
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
