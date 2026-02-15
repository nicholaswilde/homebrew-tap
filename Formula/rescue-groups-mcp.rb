# typed: false
# frozen_string_literal: true

class RescueGroupsMcp < Formula
  desc "🐶 An MCP server to interface with Rescue Groups written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/rescue-groups-mcp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.4.0/rescue-groups-mcp-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "3e114a3ce0e32f90ba2d0e68f5c988ca0fa65d86175999c37695faa9b8b20723"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.4.0/rescue-groups-mcp-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "82cd59e3047893ffc1b2f600af6e47c3fd1480298e68e19d076d1842b3470a0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.4.0/rescue-groups-mcp-0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9fb3ab27af64c11f2812357d788afc73f51722c896c39d0b922c6bb4918b033f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.4.0/rescue-groups-mcp-0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "cb036eb5b24fada36128cd0689b849284cca426bd80f67ca5cd652765e517bbf"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.4.0/rescue-groups-mcp-0.4.0-arm-unknown-linux-gnueabihf.tar.gz"
      sha256 "0bc49d92088af4b25091d4037ec484ede6b39658dbc6bfcf9b45a1da10104916"
    end
  end

  def install
    bin.install "rescue-groups-mcp"
  end

  test do
    system "#{bin}/rescue-groups-mcp", "--help"
  end
end
