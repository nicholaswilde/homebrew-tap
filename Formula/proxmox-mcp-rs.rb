# typed: false
# frozen_string_literal: true

class ProxmoxMcpRs < Formula
  desc "🦀 A rust implementation of a proxmox MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/proxmox-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.35/proxmox-mcp-rs-0.3.35-aarch64-apple-darwin.tar.gz"
      sha256 "882bc1206ab1f03f5ec732a99527307457e0029f198f4e5b47f4964c8283653a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.35/proxmox-mcp-rs-0.3.35-x86_64-apple-darwin.tar.gz"
      sha256 "f01f6521f32a19b1bae4901e38be998c6523b7243484c5589f72f6a9a63c84ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.35/proxmox-mcp-rs-0.3.35-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b822337730b9e4016524ab67c68d64de30022354108da3f1588aa3495deb4a3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.35/proxmox-mcp-rs-0.3.35-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5378a35a06cbe0302ae045f6432deddcb321ce73401f40cd05708b95d783b796"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.35/proxmox-mcp-rs-0.3.35-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "66274368c1857037fc581d81d8f96763d547af12f2ff581a29680b49b20f2e06"
      else
        url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.35/proxmox-mcp-rs-0.3.35-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "b55257145ef3d1acce965ce8553976d536001ae6cc6f0911a8e8860ac725b4b9"
      end
    end
  end

  def install
    bin.install Dir["**/proxmox-mcp-rs"].first
  end

  test do
    system "#{bin}/proxmox-mcp-rs", "--help"
  end
end
