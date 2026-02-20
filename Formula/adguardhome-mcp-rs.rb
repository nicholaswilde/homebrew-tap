# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.16/adguardhome-mcp-rs-0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "a68e0f14ecd2392f252ed2c2461b036dd861f7ee37c0cac2fb3740ab14a1b8aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.16/adguardhome-mcp-rs-0.1.16-x86_64-apple-darwin.tar.gz"
      sha256 "cd6dbb59496234438e8eb731fe040e16f63f32bf046e623aa6605715f7985a2b"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.16/adguardhome-mcp-rs-0.1.16-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d1f52699fc3902643942ae1647f5c35a44c6e615219c4c305fe1079b581bdff4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.16/adguardhome-mcp-rs-0.1.16-x86_64-unknown-linux-musl.tar.gz"
      sha256 "a7a0260d8e62f61d027ca5b435e9177bf2bb24c1b1ecb9e735181867d102821a"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.16/adguardhome-mcp-rs-0.1.16-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "86c9f49ac6355b988ac1a5832e574e40b97e3c4f590e42b33939759ad03d9e4a"
    end
  end

  def install
    bin.install Dir["**/adguardhome-mcp-rs"].first
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--help"
  end
end
