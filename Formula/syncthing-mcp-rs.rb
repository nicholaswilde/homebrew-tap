# typed: false
# frozen_string_literal: true

class SyncthingMcpRs < Formula
  desc "🔄 An MCP server written in Rust for controlling SyncThing 🤖"
  homepage "https://github.com/nicholaswilde/syncthing-mcp-rs"
  version "0.1.14"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.14/syncthing-mcp-rs-0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "e8e7c5ca5072a7268a054903b061eb7c1312fcfbb46a7d95c5d0c2a72569a23b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.14/syncthing-mcp-rs-0.1.14-x86_64-apple-darwin.tar.gz"
      sha256 "5e874669eda6a5d53d7db738081c263ac5ec8ebaae2447a5b7fa4f17a17e16bb"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.14/syncthing-mcp-rs-0.1.14-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dfd90364a0c250dde9282848da6287feabc8f00cf8f13c70f54d71e5b9766911"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.14/syncthing-mcp-rs-0.1.14-x86_64-unknown-linux-musl.tar.gz"
      sha256 "6c977672809f555fdff097b725b1951c1e5400bf985fc98dc370685e2eef1c8e"
    end
  end

  def install
    bin.install Dir["**/syncthing-mcp-rs"].first
  end

  test do
    system "#{bin}/syncthing-mcp-rs", "--help"
  end
end
