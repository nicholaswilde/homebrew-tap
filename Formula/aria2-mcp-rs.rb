# typed: false
# frozen_string_literal: true

class Aria2McpRs < Formula
  desc "Rust implementation of an aria2 MCP server"
  homepage "https://github.com/nicholaswilde/aria2-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.23/aria2-mcp-rs-0.1.23-aarch64-apple-darwin.tar.gz"
      sha256 "a93fbb00d94b8e1ae21c092b6fc7814ed565d5af9297be7020849f1e48173fa2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.23/aria2-mcp-rs-0.1.23-x86_64-apple-darwin.tar.gz"
      sha256 "9d39ddd4b8ba5af99554e51e3b3c768d26d0d1f1ed333da0875d1da0759fa4ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.23/aria2-mcp-rs-0.1.23-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5142b821b6cdfb618cd27c660bd025d35cc95e616c3b5ec189aac11465618881"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.23/aria2-mcp-rs-0.1.23-x86_64-unknown-linux-musl.tar.gz"
      sha256 "150c6ab9bf39b3b80966c38b062594e8ce7b41ad64a6d15b383a6379016b4951"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.23/aria2-mcp-rs-0.1.23-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "01bf23f234930e2a0e6f6e5594a7e92bb22829e956a677ca08f88a5f514518ed"
    end
  end

  def install
    bin.install Dir["**/aria2-mcp-rs"].first
  end

  test do
    system "#{bin}/aria2-mcp-rs", "--help"
  end
end
