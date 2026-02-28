# typed: false
# frozen_string_literal: true

class Aria2McpRs < Formula
  desc "Rust implementation of an aria2 MCP server"
  homepage "https://github.com/nicholaswilde/aria2-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.24/aria2-mcp-rs-0.1.24-aarch64-apple-darwin.tar.gz"
      sha256 "0cb3622acb2c2926773eefdae7eaea35656497cd1c6b0944d3a2585e77d823bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.24/aria2-mcp-rs-0.1.24-x86_64-apple-darwin.tar.gz"
      sha256 "10159adc4a292498e0f9e318e7e745a423eb5d79c67bbbc2339d6dca93a590d0"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.24/aria2-mcp-rs-0.1.24-aarch64-unknown-linux-musl.tar.gz"
      sha256 "75220fa34346cbd89a8d3df6b42e03df3c8c19e9146105ff6fed1763b5eb101c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.24/aria2-mcp-rs-0.1.24-x86_64-unknown-linux-musl.tar.gz"
      sha256 "bb6249b6eed3e0f489de9d2914571e005d075f8837180b47cdd2d40cde6419f7"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.24/aria2-mcp-rs-0.1.24-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "bb258d86a4d22e63046b5dba272b29f00f19a2fd5a613317b5f353b22ce64744"
    end
  end

  def install
    bin.install Dir["**/aria2-mcp-rs"].first
  end

  test do
    system "#{bin}/aria2-mcp-rs", "--help"
  end
end
