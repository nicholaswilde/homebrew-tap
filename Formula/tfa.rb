# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.15/tfa-0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "56e42daabd372141805d816a04782a4c847256243124386907591b596d794f5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.15/tfa-0.1.15-x86_64-apple-darwin.tar.gz"
      sha256 "c88c6c0c9459038e5e1b04e4b649b88f29b92c3785f11622a8fbe4c4d779e0ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.15/tfa-0.1.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "90d788cd0cb48e8993ae5d8d29d3964e5da9165b59fd3fe850d53e2b75186e5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.15/tfa-0.1.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1c748426eef4d4d08b448a30e9b4c5f24b00b815c2851dec95d5e730bd9f6afe"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.15/tfa-0.1.15-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "89f97ac2dfee16c8fb2716e1825b0cecef6dd7a78f0f877aecc9f8882b09481b"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.15/tfa-0.1.15-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "fb94b1f6157489ffe425df3bb588f6a4019fe6d6433b8c95aa42401e43875350"
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
