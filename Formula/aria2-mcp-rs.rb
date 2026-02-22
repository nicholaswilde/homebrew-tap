# typed: false
# frozen_string_literal: true

class Aria2McpRs < Formula
  desc "🦀 A rust implementation of an aria2 MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/aria2-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.8/aria2-mcp-rs-0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "b765c036b78459686a4661842f8780139b6d484a78f9b9933cff3e88fcef40d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.8/aria2-mcp-rs-0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "076bcba00869e7ae951c7a7c70811cda38dff0a63b83ea6a6d4757949cd9e73c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.8/aria2-mcp-rs-0.1.8-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e10d334ddbb7093f6e605f8cedd8ff786beb050d08fa707e29b847b26b90ca8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.8/aria2-mcp-rs-0.1.8-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ccc2192e74933f691dbfef207160a4951b6ca955a2ee4158acaad08044e37ccd"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.8/aria2-mcp-rs-0.1.8-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "eb7bbe4b9d55efa0cef93553a3e3f718136d3ab61cbe97d7f4c17747f6cb1f79"
    end
  end

  def install
    bin.install Dir["**/aria2-mcp-rs"].first
  end

  test do
    system "#{bin}/aria2-mcp-rs", "--help"
  end
end
