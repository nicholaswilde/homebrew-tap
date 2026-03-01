# typed: false
# frozen_string_literal: true

class Aria2McpRs < Formula
  desc "Rust implementation of an aria2 MCP server"
  homepage "https://github.com/nicholaswilde/aria2-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.25/aria2-mcp-rs-0.1.25-aarch64-apple-darwin.tar.gz"
      sha256 "ccb4af75b50c7171ea68944457be721c8d156b410a3a15994575e0cda32e5404"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.25/aria2-mcp-rs-0.1.25-x86_64-apple-darwin.tar.gz"
      sha256 "e4622fba1b7443087672dcbbfce1ab2001378d02f080be1daf5a0f37bd390c07"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.25/aria2-mcp-rs-0.1.25-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b6ecbb57529c025778f53473e034dc8289d8e3748d2d48f8b57451d28f328de7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.25/aria2-mcp-rs-0.1.25-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b866dcb9e602019d73c1244d4e5cd67c773ffd30269550215da7bc3d2d208435"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.25/aria2-mcp-rs-0.1.25-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "cfe523045e8bdfda3de750277829852d907011b3fc59d08cbd5226b5869f34d1"
    end
  end

  def install
    bin.install Dir["**/aria2-mcp-rs"].first
  end

  test do
    system "#{bin}/aria2-mcp-rs", "--help"
  end
end
