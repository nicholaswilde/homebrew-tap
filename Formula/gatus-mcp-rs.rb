# typed: false
# frozen_string_literal: true

class GatusMcpRs < Formula
  desc "Rust implementation of a Gatus MCP server"
  homepage "https://github.com/nicholaswilde/gatus-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.2/gatus-mcp-rs-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "cc91166361dc57163b4cbdcd94659495a72d4d3394c89580fee573c78dcc7a19"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.2/gatus-mcp-rs-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "c48f04b1c04ac5d7b8bc79cd3291fdeddc702c311137e0d9949f90f76ddb5bf9"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.2/gatus-mcp-rs-0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "5fa926ae9bc034929c390cd5fc9bf760c4a21f0fd32c34ba4d50eb0e91d6f697"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.2/gatus-mcp-rs-0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9e1c8b57551fd64236cd2dbdff9a283d55fec851e7dd3f826338f2d94d53804f"
    end
  end

  def install
    bin.install Dir["**/gatus-mcp-rs"].first
  end

  test do
    system "#{bin}/gatus-mcp-rs", "--help"
  end
end
