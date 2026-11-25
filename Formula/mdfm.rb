# typed: false
# frozen_string_literal: true

class Mdfm < Formula
  desc "Markdown frontmatter CLI: query, mutate, delete, and validate YAML and TOML"
  homepage "https://nicholaswilde.io/mdfm"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.1/mdfm-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "9c4ba9c0d84871684fea4200a560dfa1355052294d8edb035de4a7e0d6b98bb8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.1/mdfm-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "e0ff4c1a95872032183bc4dabc10ca1ffed58e28dde4f63ada61549a4fada26f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.1/mdfm-0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9f0b94b2f211cb0c390c14c8b027e08e06a86aea0a2fa360d4ac5c4d6a10bce0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.1/mdfm-0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "33d24b302d24b655f815fe14e6d3a2b910c990e23bf8d023f06f8f465f708feb"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.1/mdfm-0.1.1-arm-unknown-linux-musleabi.tar.gz"
        sha256 "c3fbddc1b6d61e37f2b994242229e56eca90edf10bf2946a6a140b0662a97376"
      else
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.1/mdfm-0.1.1-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "3af24c9d6f2dfa8203a6722faa53578169132cf56312787eb79c2de91ccb94d3"
      end
    end
  end

  def install
    bin.install Dir["**/mdfm"].first
  end

  test do
    system bin/"mdfm", "--help"
  end
end
