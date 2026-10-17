# typed: false
# frozen_string_literal: true

class QbittorrentMcpRs < Formula
  desc "🧲 A qBittorrent MCP server written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/qbittorrent-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.9/qbittorrent-mcp-rs-0.3.9-aarch64-apple-darwin.tar.gz"
      sha256 "99eb34f9c37f93a81db3672506b5d1f81d8139a7782cb8f5af3cfad99b223991"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.9/qbittorrent-mcp-rs-0.3.9-x86_64-apple-darwin.tar.gz"
      sha256 "2ad15a93f23d8404a1bb1265a753df0200c55f3f2de36ef6afd5064186190330"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.9/qbittorrent-mcp-rs-0.3.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "93eddc2822a0dd2514b215491dff3d1ffe5b54c60f023fd05fa02414d984008f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.9/qbittorrent-mcp-rs-0.3.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "1efda55c41357b24ffde520e2f65db25dbfecd65454108474fc3e2b6d527f504"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.9/qbittorrent-mcp-rs-0.3.9-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "7ced852ece2c299d3f330cd2c8a84a46618a25f8d86cb5c15ad79eacd6f5b21a"
      else
        url "https://github.com/nicholaswilde/qbittorrent-mcp-rs/releases/download/v0.3.9/qbittorrent-mcp-rs-0.3.9-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "340fc1f7aad65a072ce701ffe942dfed97ae9f959c704b372f2cbc7298a41fb2"
      end
    end
  end

  def install
    bin.install Dir["**/qbittorrent-mcp-rs"].first
  end

  test do
    system "#{bin}/qbittorrent-mcp-rs", "--help"
  end
end
