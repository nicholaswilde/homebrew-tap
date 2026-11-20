# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.18/tfa-0.1.18-aarch64-apple-darwin.tar.gz"
      sha256 "4941b1719eb1e1d45bfb67210efd03af1d3683498e73985d59b49b9791121493"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.18/tfa-0.1.18-x86_64-apple-darwin.tar.gz"
      sha256 "09a3718268c4ebab3c2320fa14f2efdff75b557efa5353db8434d98c6cbc9d5b"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.18/tfa-0.1.18-aarch64-unknown-linux-musl.tar.gz"
      sha256 "062d296d62f95a8d3da913d66cf38e4e50890ab18c6c6cc6718c0ae37b05b697"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.18/tfa-0.1.18-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e997507acb53966acf3e857cce6f50aac0c6385cb954dab5ec6fb05875c20a67"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.18/tfa-0.1.18-arm-unknown-linux-musleabi.tar.gz"
        sha256 "b300ec28c457fa89abf5e8606851e26eacdc9607b8629e7f5358612c1894c84f"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.18/tfa-0.1.18-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "ebf994baa5a1213517b7b29b855527276239123409705284a95c344a8d84a506"
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
