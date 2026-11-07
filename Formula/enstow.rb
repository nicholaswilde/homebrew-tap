# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.9/enstow-0.1.9-aarch64-apple-darwin.tar.gz"
      sha256 "497e498968176e19fdad4c2475f83ce4707ce594e3fa0058ca2f0737c95f89e3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.9/enstow-0.1.9-x86_64-apple-darwin.tar.gz"
      sha256 "aacd3ca7bb6b1090d02a2db93b0d84b3169c75ce81f4a36a10e6c127a9655e76"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.9/enstow-0.1.9-aarch64-unknown-linux-musl.tar.gz"
      sha256 "d5e64feb889c1e0027e3e0e5104158fdf3dbb06a543aaa8ceb449276253201a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.9/enstow-0.1.9-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5cf1531f41924defca0920d5ea362176fc4966cd16143ee5e61546656383388b"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.9/enstow-0.1.9-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "e57926a644265c8ae2f995cbb6f4fb068d297d23ce8611300c1e8cdb90bd1831"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.9/enstow-0.1.9-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "57a6e13ff093b341af46fe760bc26eec93fcbb34034adbd24923236f188278ff"
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
