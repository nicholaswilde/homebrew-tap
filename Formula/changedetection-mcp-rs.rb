# typed: false
# frozen_string_literal: true

class ChangedetectionMcpRs < Formula
  desc "Rust implementation of a ChangeDetection.io MCP server"
  homepage "https://github.com/nicholaswilde/changedetection-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.6/changedetection-mcp-rs-0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "6e35062266ec2871dcc14a282cfbd4c0c97acf5a8b1e60621614c694efcb0648"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.6/changedetection-mcp-rs-0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "d5b7bd53f6f4c62abb78bbf8f7efa0a7785d789cf8bb74ec17c29f70fce4506f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.6/changedetection-mcp-rs-0.1.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f933e42bb4427a0015b3d67c779cecce82d586564b56979a2925556cc6027f1a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/changedetection-mcp-rs/releases/download/v0.1.6/changedetection-mcp-rs-0.1.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "795ea168a1892403bf2ee73bf20399efb5de05a24853a5445c27598e98ed68f2"
    end
  end

  def install
    bin.install Dir["**/changedetection-mcp-rs"].first
  end

  test do
    system bin/"changedetection-mcp-rs", "--help"
  end
end
