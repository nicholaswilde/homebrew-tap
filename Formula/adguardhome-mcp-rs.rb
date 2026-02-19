# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.15/adguardhome-mcp-rs-0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "3ee14af3be3b64b0fb4525a1b71dcb4869f42f4f9d4ac4a8bb5c50d0c4a947c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.15/adguardhome-mcp-rs-0.1.15-x86_64-apple-darwin.tar.gz"
      sha256 "9fa93b74d163c3a9925b0d1ead1573ac417a46902c4564a805a96d28a3ba55ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.15/adguardhome-mcp-rs-0.1.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c3ad5803135605fc23df0db80c7ecb5e013c72032a92cba6fa596f736b3f6feb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.15/adguardhome-mcp-rs-0.1.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "8babd0593ebef77f945e5051e3795797a34d054622f7b88226b28842fc403ad9"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.15/adguardhome-mcp-rs-0.1.15-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "bdf9df61667d3b3c11b075a20ab57c91fa3e4d91c426170369ef37742d000922"
    end
  end

  def install
    bin.install Dir["**/adguardhome-mcp-rs"].first
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--help"
  end
end
