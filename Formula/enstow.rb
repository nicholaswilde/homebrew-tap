# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.17/enstow-0.1.17-aarch64-apple-darwin.tar.gz"
      sha256 "a112786bdf2edb5d397bc6d1baccc886ce8d56a43e418e84116eb2bf01877546"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.17/enstow-0.1.17-x86_64-apple-darwin.tar.gz"
      sha256 "3d5696274cf8de43f3d94eac048f2117031ca5ec8d5db2495add6137f46b8990"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.17/enstow-0.1.17-aarch64-unknown-linux-musl.tar.gz"
      sha256 "42f8eac075ddaeb088f6afa1f6f402e0e958bef6593ed012395912fe3d70b642"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.17/enstow-0.1.17-x86_64-unknown-linux-musl.tar.gz"
      sha256 "57b01e98e682be04f9b6ced0a8b8ce2f2a4a0b4d93828c83b71a12eba83588be"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.17/enstow-0.1.17-arm-unknown-linux-musleabi.tar.gz"
        sha256 "dd04f74efe86ea241bc93900b4270320d815acd7a040aaacb2d1558357baa4f7"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.17/enstow-0.1.17-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "9b1b22ab785ba2641c898ce091d3d1b0fa34306745ce8a8e22fef8277bf77bf2"
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
