# typed: false
# frozen_string_literal: true

class Aria2McpRs < Formula
  desc "🦀 A rust implementation of an aria2 MCP server. 🤖"
  homepage "https://github.com/nicholaswilde/aria2-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.21/aria2-mcp-rs-0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "374e04010a4f38d326dca0f743eef6b6bd4adc8a448899b31ae4e4ac6de55877"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.21/aria2-mcp-rs-0.1.21-x86_64-apple-darwin.tar.gz"
      sha256 "18db971b2823261751b2ba6d680c04c49d340dd36bb9e236bf117f96698c8de4"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.21/aria2-mcp-rs-0.1.21-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a31018dd00afccae7c5a6d73dfd204555604b049c382c26bce3c722838c70344"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.21/aria2-mcp-rs-0.1.21-x86_64-unknown-linux-musl.tar.gz"
      sha256 "e04c4755395cc12ec973a498bd2e174192d2448506fee0c0d51dd4a2adcb158c"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/aria2-mcp-rs/releases/download/v0.1.21/aria2-mcp-rs-0.1.21-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "3e9130a85fe4509d575507239274c9df25e9ad4e07ae40a403623c14885897e9"
    end
  end

  def install
    bin.install Dir["**/aria2-mcp-rs"].first
  end

  test do
    system "#{bin}/aria2-mcp-rs", "--help"
  end
end
