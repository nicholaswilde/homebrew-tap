# typed: false
# frozen_string_literal: true

class ProxmoxMcpRs < Formula
  desc "🦀 A rust implementation of a proxmox MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/proxmox-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.32/proxmox-mcp-rs-0.3.32-aarch64-apple-darwin.tar.gz"
      sha256 "ac894ce5c5389a64d6af0ce90ce0fed8280600a6acbfe3d3aa3fcacdd6c6ab20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.32/proxmox-mcp-rs-0.3.32-x86_64-apple-darwin.tar.gz"
      sha256 "2890b84147401c498dbaf906c2d0b7beda0d4290a6e7f479b038edd67d49085c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.32/proxmox-mcp-rs-0.3.32-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e889aea43fdf2385fa7ba80b0c4f3afbdbba455c20182510ac32962ccc763070"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.32/proxmox-mcp-rs-0.3.32-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e99e847d2c30db19066b0225c238bdd6cc4c1ede1567407443b199df40e4d359"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.32/proxmox-mcp-rs-0.3.32-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "9b2a97ad545a4ade84ba84fc0ee0249589f0f142f10f44d82937d302124f59ae"
    end
  end

  def install
    bin.install Dir["**/proxmox-mcp-rs"].first
  end

  test do
    system "#{bin}/proxmox-mcp-rs", "--help"
  end
end
