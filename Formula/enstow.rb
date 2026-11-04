# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.4/enstow-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "684d85ecc5198fa5d4b3c20e8211a325bfcd703f5e6e3a7d815a7e218cc8e1a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.4/enstow-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "f6f27aac7bdb8eebb51019aaf4fe0b8f68ff01e2db3ff6574683922f6ca78c0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.4/enstow-0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ea1d4de7cf51e5657e56cb076b93ae5e5ea88701839a7773423e670d283d4f14"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.4/enstow-0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "732c44642bd268387e2d9a3257df2bf37214a6578fb05bce5f223aef57aea18a"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.4/enstow-0.1.4-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "6ed725bcb43e65d1aac650ba7caecf2c7fb46c7a16f6479cfaf2b934116e4549"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.4/enstow-0.1.4-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "7f6ce5bd098a3f31d16b722f40bf4404c9e8ac23d77564356615d28a2e421423"
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
