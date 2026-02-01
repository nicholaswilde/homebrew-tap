# typed: false
# frozen_string_literal: true

class ProxmoxMcpRs < Formula
  desc "🦀 A rust implementation of a proxmox MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/proxmox-mcp-rs"
  version "0.3.29"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.29/proxmox-mcp-rs-0.3.29-aarch64-apple-darwin.tar.gz"
      sha256 "694eb17d635bfc0b4a06806a3eef2d4cc33ecf9fbc394e97e476a1066a18ec4d"

      def install
        bin.install "proxmox-mcp-rs-0.3.29-aarch64-apple-darwin/proxmox-mcp-rs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.29/proxmox-mcp-rs-0.3.29-x86_64-apple-darwin.tar.gz"
      sha256 "a84c01ef4739d01f3f1ee65d5d256286b56f157b7af674233a2f18e842314a44"

      def install
        bin.install "proxmox-mcp-rs-0.3.29-x86_64-apple-darwin/proxmox-mcp-rs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.29/proxmox-mcp-rs-0.3.29-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f0e9e58deadc93e023ef3fa9fdc521d708ae4f6b43cdba0fbe2d88ce00d52ee7"

      def install
        bin.install "proxmox-mcp-rs-0.3.29-aarch64-unknown-linux-musl/proxmox-mcp-rs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.29/proxmox-mcp-rs-0.3.29-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ced75851284a3b0970dc80f3a3e27a6d66da9fdcd902afde3b7f46475dfb9ec3"

      def install
        bin.install "proxmox-mcp-rs-0.3.29-x86_64-unknown-linux-musl/proxmox-mcp-rs"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.29/proxmox-mcp-rs-0.3.29-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "cbe4b9a8ec26fddb6b25737eb40a31e818bf6dc68ca232595169f4d7a8e3573b"

      def install
        bin.install "proxmox-mcp-rs-0.3.29-arm-unknown-linux-gnueabihf/proxmox-mcp-rs"
      end
    end
  end

  test do
    system "#{bin}/proxmox-mcp-rs", "--version"
  end
end
