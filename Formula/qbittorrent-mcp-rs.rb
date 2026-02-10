# typed: false
# frozen_string_literal: true

class QbittorrentMcpRs < Formula
  desc "🧲 A qBittorrent MCP server written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/qbittorrent-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.0/qbittorrent-mcp-rs-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "7305e710b10dd8fa48dd7cc05778311c3b5ab01e02b6d5152564bde30712b9be"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.0/qbittorrent-mcp-rs-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "a153608d7167dc5fe8ce32d30ed5995fae7354a41b901075e1205510fa0227b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.0/qbittorrent-mcp-rs-0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "00d1b7a8d2819afbb396c5082ad8758e6885404d45f6d41830552bc025e2cb56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.0/qbittorrent-mcp-rs-0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "da129fc1e62a9bf936ab5745cc551e10791534486596e76de392fdb6cd4b5578"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.0/qbittorrent-mcp-rs-0.3.0-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "d6051d2532372be2140b3281e4b1efdfbc0fa99e91ed8baf4e20001f877d5621"
    end
  end

  def install
    bin.install Dir["**/qbittorrent-mcp-rs"].first
  end

  test do
    system "#{bin}/qbittorrent-mcp-rs", "--help"
  end
end
