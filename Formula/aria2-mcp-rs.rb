# typed: false
# frozen_string_literal: true

class Aria2McpRs < Formula
  desc "🦀 A rust implementation of an aria2 MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/aria2-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.17/aria2-mcp-rs-0.1.17-aarch64-apple-darwin.tar.gz"
      sha256 "313b380b937f9275f5ec6bc13dfd376eb33227b611d1843128cf6a29a0c526fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.17/aria2-mcp-rs-0.1.17-x86_64-apple-darwin.tar.gz"
      sha256 "49fdc4ecff4559d23ff2b1922a54c5a4e19ff1bb42f253dd82e838d4a47bf5c7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.17/aria2-mcp-rs-0.1.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8b50c991cc528d1698c6ceec3678b224a185af89bab7168b56c12bfe463b0322"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.17/aria2-mcp-rs-0.1.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "82916503ddc7eba4411af1744b3f2a4a0db74bfd8ad02f5761717ccc469d64bc"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.17/aria2-mcp-rs-0.1.17-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "9f03594503da9ded97a679fc827aa21277037bbbeb9b42f3f031a46904338e91"
    end
  end

  def install
    bin.install Dir["**/aria2-mcp-rs"].first
  end

  test do
    system "#{bin}/aria2-mcp-rs", "--help"
  end
end
