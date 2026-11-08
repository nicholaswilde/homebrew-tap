# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.12/enstow-0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "c6e71f72b1de42b733fc8f20f856f8abeccd3d98396c4113ba429e1e59635e4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.12/enstow-0.1.12-x86_64-apple-darwin.tar.gz"
      sha256 "cff42d74932332c166d9586ddcc936a3050d6c5d5d7aa52e8862f8cdd7c27726"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.12/enstow-0.1.12-aarch64-unknown-linux-musl.tar.gz"
      sha256 "39c4b1ff2e02fb5894461b1d7833c1e12e2cbb01bc955605b65a8ea826bb76b8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.12/enstow-0.1.12-x86_64-unknown-linux-musl.tar.gz"
      sha256 "387c163ddb477f69fc01eecab09aef62ddc33ed47c95df00009920f4cc2c9b5d"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.12/enstow-0.1.12-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "299721ef1cbd8191aae3a8e14568f4a97c8916b9fe4898f2ed7a73b07803f857"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.12/enstow-0.1.12-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "370fe5e34bc2266217353d585fdf77a23573acef1fc7c0c33938e795f3f01905"
      end
    end
  end

  def install
    bin.install Dir["**/enstow"].first
  end

  test do
    system "#{bin}/enstow", "--help"
  end
end
