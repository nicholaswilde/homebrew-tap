# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.8/adguardhome-mcp-rs-0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "6f35617b30bee1828fa9c373eb3c4977f4305c22aee14dd4d8d6f2e79362ace9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.8/adguardhome-mcp-rs-0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "a8f22f8768909ad7348bec1dcef779a609eb96ba76ebc1a55f18bd3b543ed579"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.8/adguardhome-mcp-rs-0.1.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3a4c09946696cc9bd73abf73348edf3923145f199ebed187dc6fd8f4fdc128ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.8/adguardhome-mcp-rs-0.1.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1bb64b95bfd60728891f80240fd1617b73a5a744ee7b42affa4527a3e0e10da2"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.8/adguardhome-mcp-rs-0.1.8-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "d2e561d79e8c42dfffb451aee18b549a919e7abd4f3551218f864140d4193d90"
    end
  end

  def install
    bin.install Dir["**/adguardhome-mcp-rs"].first
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--version"
  end
end
