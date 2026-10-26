# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.2/tfa-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "6afe0c21fe8800b87e9b1f73595e666a87d04074259ae8b3d7e5757a3e65528a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.2/tfa-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "981b27980b1e36b6c626d61a7ee7bfbdc77320b2a26ee190f3f3b9ce2c6a77f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.2/tfa-0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5b43f5deed811777904118c43185f219d9dddbb9a095ce0f1d5804a2d4244709"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.2/tfa-0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f376011332ed79f5bcac5b5a20bcfa16059004d74837e6d436dc27aeee76c7ad"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.2/tfa-0.1.2-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "73faa5dd904aea1998e9026acee7ec2287e4a96f664c068342aef5c76977966b"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.2/tfa-0.1.2-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "d21f03c810813bd49eaff2998d7514d432ee24f3f94dbbbdf740c186373dcc1c"
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
