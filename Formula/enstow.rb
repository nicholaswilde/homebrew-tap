# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.15/enstow-0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "c188c8481f8bb2540630610e097c11c5024df5bf503746095f203116d1484e20"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.15/enstow-0.1.15-x86_64-apple-darwin.tar.gz"
      sha256 "a53e5444ee3d5ebb27e22a813c7858e2bcf2cfeed3aeaafc4685bf8d0513a3fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.15/enstow-0.1.15-aarch64-unknown-linux-musl.tar.gz"
      sha256 "145cef72a4e6ea617d699c5213bb83c7f3c0e334fb4b697315d1ea3db3452bd9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.15/enstow-0.1.15-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4e060c73a9f1dcb7b1acfad2f83700ce3832b4b317de7ccc80a15a3f972bdc19"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.15/enstow-0.1.15-arm-unknown-linux-musleabi.tar.gz"
        sha256 "e226df627ddc849335ac69ac1973c812b967b7feb0d3799b8551ed13dbe39db3"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.15/enstow-0.1.15-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "34c8feb29da6a06cc63a9958a7726a3f7654c0e6ea50f9d539c407d78dd21f99"
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
