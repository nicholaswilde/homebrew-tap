# typed: false
# frozen_string_literal: true

class Mdfm < Formula
  desc "Markdown frontmatter CLI: query, mutate, delete, and validate YAML and TOML"
  homepage "https://nicholaswilde.io/mdfm"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.0/mdfm-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "4c7bc4aae6beef47239209a1aca0cc04cb7b2ec7a212615336c8a4cc0a7989cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.0/mdfm-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "e44745b7aed756566b2f317d1b07d48117762dd932013c40c614de9472891fb1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.0/mdfm-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "f19cc97ad243d33c925e6527908db072ac9b979b949b6c584c63d98d7c956ff5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.0/mdfm-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ba0ffad478253416346edb43798f5656a7acbe1e8cd0e3f7dfffc583c789cfd0"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.0/mdfm-0.1.0-arm-unknown-linux-musleabi.tar.gz"
        sha256 "b9ef93073e6d2ad059334fea7bc65f55a3f3cee57d2a8864ed08335cecd5453b"
      else
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.0/mdfm-0.1.0-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "994f7ea58936645921e5b9f3d3d681df3b9a5077b00369d3d379764bb14e8ca6"
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
