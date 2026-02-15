# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.11/adguardhome-mcp-rs-0.1.11-aarch64-apple-darwin.tar.gz"
      sha256 "805481472e75c1866657186393cb573b75f9b1bcc2b960eb392b1397ef989cda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.11/adguardhome-mcp-rs-0.1.11-x86_64-apple-darwin.tar.gz"
      sha256 "012331a1130cd7576d6d6f7a0d368444bdffde4b173ff9c57cfe0c3e9126cdb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.11/adguardhome-mcp-rs-0.1.11-aarch64-unknown-linux-musl.tar.gz"
      sha256 "cc2669c39d714f2984a7d729d38c4a143536fbc4fd7090b61778e6d220b0af30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.11/adguardhome-mcp-rs-0.1.11-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4532c904fde65973c7cbf448876b07a875bd5acf87c10a88810749008667b990"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.11/adguardhome-mcp-rs-0.1.11-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "a43ba45b26f3f25daf90467ca2090ae5acaece7413e9d18f72fbe550184b343f"
    end
  end

  def install
    bin.install Dir["**/adguardhome-mcp-rs"].first
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--help"
  end
end
