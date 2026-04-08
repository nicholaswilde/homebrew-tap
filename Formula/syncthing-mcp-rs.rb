# typed: false
# frozen_string_literal: true

class SyncthingMcpRs < Formula
  desc "🔄 An MCP server written in Rust for controlling SyncThing 🤖"
  homepage "https://github.com/nicholaswilde/syncthing-mcp-rs"
  version "0.1.19"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.19/syncthing-mcp-rs-0.1.19-aarch64-apple-darwin.tar.gz"
      sha256 "467833e9df40b598ab71a6d53427c1203779f0355bb7ae7bf9b5c92394ef41ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.19/syncthing-mcp-rs-0.1.19-x86_64-apple-darwin.tar.gz"
      sha256 "dccf6fdb1e9ebd0ceabc5c17a9ca5a3ff3ed21f379dbfc4fa265889cfa231822"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.19/syncthing-mcp-rs-0.1.19-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2ee9648bd9d5dfc67000d6dd0ea8e285ca1703ba69bd37a0f45c1696319c342b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/syncthing-mcp-rs/releases/download/v0.1.19/syncthing-mcp-rs-0.1.19-x86_64-unknown-linux-musl.tar.gz"
      sha256 "09abf7c3e57959c0103847d8f901595af9cd828f15d4fa6d12ca1db0c0bbb882"
    end
  end

  def install
    bin.install Dir["**/syncthing-mcp-rs"].first
  end

  test do
    system "#{bin}/syncthing-mcp-rs", "--help"
  end
end
