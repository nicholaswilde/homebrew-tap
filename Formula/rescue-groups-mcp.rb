# typed: false
# frozen_string_literal: true

class RescueGroupsMcp < Formula
  desc "🐶 An MCP server to interface with Rescue Groups written in Rust 🤖"
  homepage "https://github.com/nicholaswilde/rescue-groups-mcp"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.3.1/rescue-groups-mcp-darwin-arm64.tar.gz"
      sha256 "59e2203bb628dd0fbcd043c54fcbd65e881f700795dd6153dd9f153ec1676a98"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.3.1/rescue-groups-mcp-darwin-amd64.tar.gz"
      sha256 "37111f8200daf59ef7768309e1d7a280a328cc4aed6b4f6aafc8e0edf3dea0b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.3.1/rescue-groups-mcp-linux-arm64.tar.gz"
      sha256 "d28b8365f13649153e1fa47c98f4e9f2d847527e3bf266d631918f627bb29803"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/rescue-groups-mcp/releases/download/v0.3.1/rescue-groups-mcp-linux-amd64.tar.gz"
      sha256 "b76d921021fc61b8bed949cdc175a90991457d2fcbf6da079c9bb6f05f11c4c2"
    end
  end

  def install
    bin.install "rescue-groups-mcp"
  end

  test do
    system "#{bin}/rescue-groups-mcp", "--help"
  end
end
