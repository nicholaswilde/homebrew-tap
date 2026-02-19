# typed: false
# frozen_string_literal: true

class ProxmoxMcpRs < Formula
  desc "🦀 A rust implementation of a proxmox MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/proxmox-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.33/proxmox-mcp-rs-0.3.33-aarch64-apple-darwin.tar.gz"
      sha256 "65c385ac960c9593485e2e92d4bcc4911498b4f9cd0083c3b5be16bebe457c96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.33/proxmox-mcp-rs-0.3.33-x86_64-apple-darwin.tar.gz"
      sha256 "511e9111ced64f2a9eeccfc677c1bb60534b14c8125a30eb8846549f62d25db4"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.33/proxmox-mcp-rs-0.3.33-aarch64-unknown-linux-musl.tar.gz"
      sha256 "695d040484ad50fd08cc71bf5ee23d1e0a2f58384bf0b22634c2cebad3609ea3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.33/proxmox-mcp-rs-0.3.33-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2633e119a8c8856b987c0338f993414dafb68471d999ea82e2e119f8437e9213"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.33/proxmox-mcp-rs-0.3.33-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "2a4af30d56e9988706e0e60229e2ae608ed86f97c5cd54fa7343748a0c46cb08"
    end
  end

  def install
    bin.install Dir["**/proxmox-mcp-rs"].first
  end

  test do
    system "#{bin}/proxmox-mcp-rs", "--help"
  end
end
