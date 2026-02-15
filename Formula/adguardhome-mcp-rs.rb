# typed: false
# frozen_string_literal: true

class AdguardhomeMcpRs < Formula
  desc "🛡️ A Rust implementation of an AdGuard Home MCP (Model Context Protocol) server 🤖"
  homepage "https://github.com/nicholaswilde/adguardhome-mcp-rs"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.9/adguardhome-mcp-rs-0.1.9-aarch64-apple-darwin.tar.gz"
      sha256 "133906c5b859f39abc9eac288ce84f8af60f62d03177254d2d423a7d093acc4d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.9/adguardhome-mcp-rs-0.1.9-x86_64-apple-darwin.tar.gz"
      sha256 "6712e84eba64f9c72e808c86f13972907787b01426a831bef1b0a80dec085ffe"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.9/adguardhome-mcp-rs-0.1.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "71de9c1d696785b14a82017b1a848367a375ad0fb31b4c35e22d7ec9758924e5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.9/adguardhome-mcp-rs-0.1.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2ce52e0ae17d99f66b7450135ec151f887fb3ff589c394419c98fe58b4f8cbcd"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/adguardhome-mcp-rs/releases/download/v0.1.9/adguardhome-mcp-rs-0.1.9-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "c112d2b2e62fa137fba996e2324155dbc3e62ec0ca505afb78d8281f1078800f"
    end
  end

  def install
    bin.install Dir["**/adguardhome-mcp-rs"].first
  end

  test do
    system "#{bin}/adguardhome-mcp-rs", "--help"
  end
end
