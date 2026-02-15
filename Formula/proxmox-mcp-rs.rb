# typed: false
# frozen_string_literal: true

class ProxmoxMcpRs < Formula
  desc "🦀 A rust implementation of a proxmox MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/proxmox-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.31/proxmox-mcp-rs-0.3.31-aarch64-apple-darwin.tar.gz"
      sha256 "1c6f4511038d5586da8f579d7d94213bcfcce48b00cca971f504beff3bf0c368"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.31/proxmox-mcp-rs-0.3.31-x86_64-apple-darwin.tar.gz"
      sha256 "149758b6594cff918465ef8d82bf5c0562ba01d37333c3d49967ceafdb4fd506"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.31/proxmox-mcp-rs-0.3.31-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9fd777d4271b1259b230c4516e0a5542d99ca70842a6e32ce1fe69ca10dd7373"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.31/proxmox-mcp-rs-0.3.31-x86_64-unknown-linux-musl.tar.gz"
      sha256 "db1262e380ded53d7b906d038e3c0759dafb160052f830b6b9dc2d4efbe5f71e"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.31/proxmox-mcp-rs-0.3.31-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "665b67e2ec5ecc2fb5f6fa73dec85332d81ec78749fd712296d7a6c0789aec33"
    end
  end

  def install
    bin.install Dir["**/proxmox-mcp-rs"].first
  end

  test do
    system "#{bin}/proxmox-mcp-rs", "--help"
  end
end
