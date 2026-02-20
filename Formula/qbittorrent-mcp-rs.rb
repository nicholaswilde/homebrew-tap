# typed: false
# frozen_string_literal: true

class QbittorrentMcpRs < Formula
  desc "🧲 A qBittorrent MCP server written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/qbittorrent-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.6/qbittorrent-mcp-rs-0.3.6-aarch64-apple-darwin.tar.gz"
      sha256 "7a0ede503f68b98e2ffdabb4a001404697f4373957ba2fa768635a5b9dac1696"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.6/qbittorrent-mcp-rs-0.3.6-x86_64-apple-darwin.tar.gz"
      sha256 "663b5ce9f59fc72b1acaa59219f93d18deea9d38c84f4169cf22332a81401966"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.6/qbittorrent-mcp-rs-0.3.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "28bd4bd04c6b03cc464206ca82f0b4ffd8ef4151e1cc712d26440b58a726db22"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.6/qbittorrent-mcp-rs-0.3.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "fa356757e05c0a800e7bc59b707a30b678b5b96fa64670632bf8594c40948bb6"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.6/qbittorrent-mcp-rs-0.3.6-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "9b0028308e1501cc2835bbe8ebe88656d78c71b5d99b6dd963613da8581a0740"
    end
  end

  def install
    bin.install Dir["**/qbittorrent-mcp-rs"].first
  end

  test do
    system "#{bin}/qbittorrent-mcp-rs", "--help"
  end
end
