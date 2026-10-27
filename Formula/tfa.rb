# typed: false
# frozen_string_literal: true

class Tfa < Formula
  desc "🔐 Fast, lightweight, and secure command-line Two-Factor Authentication (2FA/TOTP/HOTP) generator and manager in Rust 🦀"
  homepage "https://github.com/nicholaswilde/tfa"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.4/tfa-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "7457cceaf15557de166e179d7f9e11caee64350ff23f77dcb9d2a54bd90cfafd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.4/tfa-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "c63816329ee7b6ccc5d4730264abcac8e114a4edb6b918f6293c8a409bd48aef"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.4/tfa-0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "580e53586f0ef0b49dc5ca5e4b54dcb8c846eb874d22c6dc2b1d3d7d71a09996"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.4/tfa-0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7004c7d185257544fb433d4022d3ce70e1a74a6c616c3dbbcf04297422ba0f63"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.4/tfa-0.1.4-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "acf6f777ce54399d9359c3a5b68f2a20f5cb03593b318c5612de3c542037cfde"
      else
        url "https://github.com/nicholaswilde/tfa/releases/download/v0.1.4/tfa-0.1.4-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "5427b8f8e2120ed978ce0463c0f1521cea98b171369c6161503a1a5e4f25a212"
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
