# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.3/enstow-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "e6c3b9c44f3886b9e54795d51f7e82490a21c81027c7ae145f73a81345bc889a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.3/enstow-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "ff807aaec3e03205d070c67076186d4ef2f169a615fbdab077c21a5b1d68f0e1"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.3/enstow-0.1.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e1c27eefdb0690dbcafe5445c861f3eccbbb129b7d81eaf1715331c6de6e5dbb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.3/enstow-0.1.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0e064d335a0b48b159b241fbec7a23b9c48e2e3f33dc85f7a7747317e4502940"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.3/enstow-0.1.3-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "6a4102e7af12c95dd66b90593e2047e7eb84dc6ecf298cd09f88690dd3bac800"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.3/enstow-0.1.3-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "44ece4c12beb56bfc3c3eefad47ad1b0bfe87fafdadcf5cbafe15e57eaabc25f"
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
