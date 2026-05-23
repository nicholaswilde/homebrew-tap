# typed: false
# frozen_string_literal: true

class GatusMcpRs < Formula
  desc "Rust implementation of a Gatus MCP server"
  homepage "https://github.com/nicholaswilde/gatus-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.4/gatus-mcp-rs-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "2c53feeb46e1974692c384364f302ee509ef84cc9431ad8834fd4096b8687170"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.4/gatus-mcp-rs-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "affca409aecdec3be2e108d9804d1d00f6a1f9af0c4a5939f4612ca2bc0fedab"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.4/gatus-mcp-rs-0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "7b16fc4ef44b4bb75a579e4c9467147a5f9b03d96a3af0ea6a845a493dd01f2d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.4/gatus-mcp-rs-0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "c06b580bc13ba7dd2b8aa3293c87abbbfba0001d72534d7ff8a508b986b250a5"
    end
  end

  def install
    bin.install Dir["**/gatus-mcp-rs"].first
  end

  test do
    system "#{bin}/gatus-mcp-rs", "--help"
  end
end
