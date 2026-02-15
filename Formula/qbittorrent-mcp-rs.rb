# typed: false
# frozen_string_literal: true

class QbittorrentMcpRs < Formula
  desc "🧲 A qBittorrent MCP server written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/qbittorrent-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.5/qbittorrent-mcp-rs-0.3.5-aarch64-apple-darwin.tar.gz"
      sha256 "a2c9b7c7bc0c6f8fd215357920db86ca55bfd21c940f8ff5499f0c74e011c651"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.5/qbittorrent-mcp-rs-0.3.5-x86_64-apple-darwin.tar.gz"
      sha256 "720d72e1ce3e0453bd3f894c27f09156f761e6d0e5b74d98066b7cd66761b352"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.5/qbittorrent-mcp-rs-0.3.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6bd1bdf2dd87d1a1304e014d3692f9e0d76bc24a62ca1aeb9678402f659ef2b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.5/qbittorrent-mcp-rs-0.3.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9a1e7ea46dd0296e39929f7fbee6065e8a69416657bf902ca327135d1d8978d6"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.5/qbittorrent-mcp-rs-0.3.5-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "bacdef0c600e98630a8b192258e19d4eabc9df601e5c1d96757c9300c359c2e2"
    end
  end

  def install
    bin.install Dir["**/qbittorrent-mcp-rs"].first
  end

  test do
    system "#{bin}/qbittorrent-mcp-rs", "--help"
  end
end
