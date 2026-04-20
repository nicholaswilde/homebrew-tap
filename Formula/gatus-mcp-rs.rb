# typed: false
# frozen_string_literal: true

class GatusMcpRs < Formula
  desc "Rust implementation of a Gatus MCP server"
  homepage "https://github.com/nicholaswilde/gatus-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.0/gatus-mcp-rs-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "8e54d64e30618cc053c4f708cf3336a10fd7962ec3a0b922aa67c95e22f572db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.0/gatus-mcp-rs-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "e74c9955d903f133eabe7c37c28096c0b66d267351ed073d70c26018bde4ce75"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.0/gatus-mcp-rs-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b6c996de560b5e430b8dc3dadce99b05d1911fbafced19990ef70ad75c4c62a0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/gatus-mcp-rs/releases/download/v0.1.0/gatus-mcp-rs-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "032bab48f631a623b8b147dcc1bd9ae177e406e5de7133c6bb0b77857236b903"
    end
  end

  def install
    bin.install Dir["**/gatus-mcp-rs"].first
  end

  test do
    system "#{bin}/gatus-mcp-rs", "--help"
  end
end
