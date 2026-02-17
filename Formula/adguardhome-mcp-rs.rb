# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.12/adguardhome-mcp-rs-0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "2ecfd3754dc9182492c9dbf2ea41476387073d9cb03bc472fa365e22d6d86967"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.12/adguardhome-mcp-rs-0.1.12-x86_64-apple-darwin.tar.gz"
      sha256 "2fbd1f8bc60f8382159923fe5996744633f31f8281fa7ba2c01afa2b81677031"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.12/adguardhome-mcp-rs-0.1.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "96c42037498d494cdd04172c20ee4c5b24243c719f642dab9d79243d13ceb7ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.12/adguardhome-mcp-rs-0.1.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a8f4fdedeb682346440704be35a7d9a397231baa98b2dfa66bed8ed7f2b122c3"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.12/adguardhome-mcp-rs-0.1.12-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "66895acebd8af6cd0ec2d142de586df8bdd5bf26cdbf1c1a5a977b9150518f85"
    end
  end

  def install
    bin.install Dir["**/adguardhome-mcp-rs"].first
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--help"
  end
end
