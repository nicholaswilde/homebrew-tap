# typed: false
# frozen_string_literal: true

class RecipesMcpRs < Formula
  desc "🍳 An MCP server that imports recipes 🤖"
  homepage "https://github.com/nicholaswilde/recipes-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/recipes-mcp-rs/releases/download/v0.1.4/recipes-mcp-rs-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "2579012bea76a8fc87df831813e0d352166e651e95c16e5425fc751305c763a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/recipes-mcp-rs/releases/download/v0.1.4/recipes-mcp-rs-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "56f59e52cf1b00920733bf1f93a68b771038ee44788f1d42d19a439ddf446b0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/recipes-mcp-rs/releases/download/v0.1.4/recipes-mcp-rs-0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8a4fcc0f44c668b9637d8a21ec44d495229e43cf833900257c6472bf94f8446e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/recipes-mcp-rs/releases/download/v0.1.4/recipes-mcp-rs-0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ab26dc3341709c3010c0f6b46fec570cd41c7e26b1fd38dc5c026bf885a74708"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/recipes-mcp-rs/releases/download/v0.1.4/recipes-mcp-rs-0.1.4-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "7c47a0f104ab47857a6d3cd33faa37e8fa4c7f7aaea1003d5b48e6e0fde29b1e"
    end
  end

  def install
    bin.install Dir["**/recipes-mcp-rs"].first
  end

  test do
    system "#{bin}/recipes-mcp-rs", "--help"
  end
end
