# typed: false
# frozen_string_literal: true

class QbittorrentMcpRs < Formula
  desc "🧲 A qBittorrent MCP server written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/qbittorrent-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.7/qbittorrent-mcp-rs-0.3.7-aarch64-apple-darwin.tar.gz"
      sha256 "82160c68f0a8bb2f82fa4e810c026a5bc16ac0c670f71c20c8bcf686340db7fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.7/qbittorrent-mcp-rs-0.3.7-x86_64-apple-darwin.tar.gz"
      sha256 "51b152051bb11fd7dda897361d04833d754fa1eb3b7ef4f1883609d0fd226a05"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.7/qbittorrent-mcp-rs-0.3.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6354696112012dd1b9c72346fce2738fc3d71b2fa36ba39f0ff5cb2496bdc16c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.7/qbittorrent-mcp-rs-0.3.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "78e7c417886e24b5c451e99cf3618549ed93b0982055537bc6367fe8358c4a4c"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.7/qbittorrent-mcp-rs-0.3.7-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "8237b6455d19e308f7c8404ff09410873f27fa92c05d97135fbc00005d88ccc0"
    end
  end

  def install
    bin.install Dir["**/qbittorrent-mcp-rs"].first
  end

  test do
    system "#{bin}/qbittorrent-mcp-rs", "--help"
  end
end
