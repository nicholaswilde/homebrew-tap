# typed: false
# frozen_string_literal: true

class ChangedetectionMcpRs < Formula
  desc "Rust implementation of a ChangeDetection.io MCP server"
  homepage "https://github.com/nicholaswilde/changedetection-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.3/changedetection-mcp-rs-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "ad7b8a6cfdbe4f23d6fce1de8e30f0f4bd8a321e396c7eb9319b2a15e209ebdf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.3/changedetection-mcp-rs-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "39a823963c34985cec81a4d7a3b34b8967bca375d7ea695558e735ef7075edaa"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.3/changedetection-mcp-rs-0.1.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "6c1c12724712dfd11349ac1beb6fa01cf2ef51adbf6bb38f90e2f930cf58f2da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.3/changedetection-mcp-rs-0.1.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "05d40c73061567496eabd5ad9f73c3fb1f21d8c68ccd7a99e1a92a9ce48745da"
    end
  end

  def install
    bin.install Dir["**/changedetection-mcp-rs"].first
  end

  test do
    system "#{bin}/changedetection-mcp-rs", "--help"
  end
end
