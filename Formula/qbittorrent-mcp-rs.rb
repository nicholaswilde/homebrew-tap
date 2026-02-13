# typed: false
# frozen_string_literal: true

class QbittorrentMcpRs < Formula
  desc "🧲 A qBittorrent MCP server written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/qbittorrent-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.3/qbittorrent-mcp-rs-0.3.3-aarch64-apple-darwin.tar.gz"
      sha256 "80800d241eae67f69303c468879d6879438a104a2f92102e08c2b40cd4eb5351"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.3/qbittorrent-mcp-rs-0.3.3-x86_64-apple-darwin.tar.gz"
      sha256 "91bfaff3c5ef29f22b1b0ffd166e38e8a6cacd4476ec1c3f296a06a3c7b75df9"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.3/qbittorrent-mcp-rs-0.3.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a9edd5cc3858014bf11c0d98aa8f1490436acc9ace61a9d428e7739122f85b5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.3/qbittorrent-mcp-rs-0.3.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5cf24b231199371651e4d09643abeef6ee4bec1c85691fa8df8f478732ea4622"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.3/qbittorrent-mcp-rs-0.3.3-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "75cf2db39596d482d5217dd8d71801167eed6d42f01e9a90579644361b081994"
    end
  end

  def install
    bin.install Dir["**/qbittorrent-mcp-rs"].first
  end

  test do
    system "#{bin}/qbittorrent-mcp-rs", "--help"
  end
end
