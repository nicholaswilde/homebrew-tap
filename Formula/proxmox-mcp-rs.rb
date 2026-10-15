# typed: false
# frozen_string_literal: true

class ProxmoxMcpRs < Formula
  desc "🦀 A rust implementation of a proxmox MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/proxmox-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.34/proxmox-mcp-rs-0.3.34-aarch64-apple-darwin.tar.gz"
      sha256 "8ea09b18c671c29785a34432c3359caf5804b6f58e8cd95154eeb0c6dc005aee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.34/proxmox-mcp-rs-0.3.34-x86_64-apple-darwin.tar.gz"
      sha256 "d67996916b6d48e688e3a8979437894b694212836e691e4c18ec198dd1cf286b"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.34/proxmox-mcp-rs-0.3.34-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d0029dcb1932d2ba91203c5ee4a03076c304af1e3fef487afb08170483a4b3ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.34/proxmox-mcp-rs-0.3.34-x86_64-unknown-linux-musl.tar.gz"
      sha256 "eaad7e0069d9dd9cc82c3501b6439078a35ca4ce3268e477fe457841cda71767"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.34/proxmox-mcp-rs-0.3.34-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "cc37eb7b9c587252883df994ed32ecd0a242dec5a9354a3fbbb7cc3259fc21e9"
      else
        url "https://github.com/nicholaswilde/proxmox-mcp-rs/releases/download/v0.3.34/proxmox-mcp-rs-0.3.34-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "7da1564c65c267d6b419a3380a803e5e2c7f22655d0a0b0ff0e1590366f44bbc"
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
