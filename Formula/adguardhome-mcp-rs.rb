# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.0/adguardhome-mcp-rs-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "1e9be405ce8258087285077b6ed4d9995aeefe7f4e43d29a65ab5c2b601b4a43"

      def install
        bin.install "adguardhome-mcp-rs-0.1.0-aarch64-apple-darwin/adguardhome-mcp-rs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.0/adguardhome-mcp-rs-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "538382d5eb25d67e9b42daea53ac3eabbb2d3fa810970f25a2bface07d4035bb"

      def install
        bin.install "adguardhome-mcp-rs-0.1.0-x86_64-apple-darwin/adguardhome-mcp-rs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.0/adguardhome-mcp-rs-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b240ffbed4eb22540fce13a586a27fc2afd1040d2bce531abe08451e4bd3e03f"

      def install
        bin.install "adguardhome-mcp-rs-0.1.0-aarch64-unknown-linux-musl/adguardhome-mcp-rs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.0/adguardhome-mcp-rs-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "793c96cdffd36cc06cd6703525270835f6f285e0bf9695b16b78adeddfd7c0cd"

      def install
        bin.install "adguardhome-mcp-rs-0.1.0-x86_64-unknown-linux-musl/adguardhome-mcp-rs"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.0/adguardhome-mcp-rs-0.1.0-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "cb6ed1a38b0b7a7680598f7943d4ec6e3077cf4d0a05ae792fc306b6525c8209"

      def install
        bin.install "adguardhome-mcp-rs-0.1.0-arm-unknown-linux-gnueabihf/adguardhome-mcp-rs"
      end
    end
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--version"
  end
end