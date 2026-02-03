# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  version "0.1.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.6/adguardhome-mcp-rs-0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "ec77aff1b4e98c0e70d12f95267de3cc5d7b9f62be06945376b382a5a3227fd4"

      def install
        bin.install "adguardhome-mcp-rs-0.1.6-aarch64-apple-darwin/adguardhome-mcp-rs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.6/adguardhome-mcp-rs-0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "6798ec82a012b7cdfd1289c6d4232ca1a9ac54717b5789fe9082c3f99e004494"

      def install
        bin.install "adguardhome-mcp-rs-0.1.6-x86_64-apple-darwin/adguardhome-mcp-rs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.6/adguardhome-mcp-rs-0.1.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "57a586a68910ced05ea279a21f599a71c835341b2edd60eb67e0b8c92d5faf3e"

      def install
        bin.install "adguardhome-mcp-rs-0.1.6-aarch64-unknown-linux-musl/adguardhome-mcp-rs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.6/adguardhome-mcp-rs-0.1.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b4f72888062e66e4ade0ea033d9af4eb2a1bae367840b5fa7f00b5384c97a5d4"

      def install
        bin.install "adguardhome-mcp-rs-0.1.6-x86_64-unknown-linux-musl/adguardhome-mcp-rs"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.6/adguardhome-mcp-rs-0.1.6-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "15f17f2671ee26f8a111d8396a2108fd0a6f9b4bc18ba2b6eae5974dd15b0d0c"

      def install
        bin.install "adguardhome-mcp-rs-0.1.6-arm-unknown-linux-gnueabihf/adguardhome-mcp-rs"
      end
    end
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--version"
  end
end
