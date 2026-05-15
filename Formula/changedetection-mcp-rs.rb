# typed: false
# frozen_string_literal: true

class ChangedetectionMcpRs < Formula
  desc "Rust implementation of a ChangeDetection.io MCP server"
  homepage "https://github.com/nicholaswilde/changedetection-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.5/changedetection-mcp-rs-0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "ccd0452214024a7ff0ceb9c5766785f24298077592a25b6dfc0f8c684cf185ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.5/changedetection-mcp-rs-0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "cc7bf754c7c2c7d5d216b88b8037c2fe3de79badc8125e66f0c11b2a3b6ccc63"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.5/changedetection-mcp-rs-0.1.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2f7ca3215694e8794239435c5946f2ef1cd433a97607ff98a69938ab78500fa1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.5/changedetection-mcp-rs-0.1.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5e374d60738c0be8b95e2e01ef4cd101e182ade286a91abdeb240da08cf3b174"
    end
  end

  def install
    bin.install Dir["**/changedetection-mcp-rs"].first
  end

  test do
    system "#{bin}/changedetection-mcp-rs", "--help"
  end
end
