# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.11/tfa-0.1.11-aarch64-apple-darwin.tar.gz"
      sha256 "1f7ff17c79070377f8a6fe3ff76ddb039c055620bf249b19a79a54c0f8a5c59b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.11/tfa-0.1.11-x86_64-apple-darwin.tar.gz"
      sha256 "e1544f731c6b3ce63e4e58e53000b09d2028c2f5bdac0bea06d1fbe56672cb23"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.11/tfa-0.1.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f49285e6743849124c43124a0db96535f53c19477520044b74b09a506f416195"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.11/tfa-0.1.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "64ceea5570d466867dc502dbcf3e30bd3b2e445429c00ffdae048706682264db"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.11/tfa-0.1.11-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "124dfd16eae0721711e59816d50b0193cee161f25084a4106da5ab063c201fd2"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.11/tfa-0.1.11-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "de5499cb46c4a92e9f2c775c874702e78fbd885bb73fd120fd2093e8b775c03f"
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
