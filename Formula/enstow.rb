# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.0/enstow-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "32aedb69bef024be409cc1c1874129a23cde2cf4a5856d6b26467d757cd2b894"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.0/enstow-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "a609f237a151373db39862bce3f62fbde6e07f7a0e76b5bb7ff221cbb136b56c"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.0/enstow-0.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3b3a369891c98fada3c9163cb2f4ffbbc1cb84e812289d77107f4a403b353513"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.0/enstow-0.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "31aa1cbd125bc7979196f0c79169604716950e78bcd82a01379ca5c4b65dd5ed"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.0/enstow-0.1.0-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "fffcb131f9cdfc9bcf143a66630fa688120497043bcca70af82eca93f257549c"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.0/enstow-0.1.0-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "cbc5d2ffc59fe74c54dd4655fb76641b444248e3c7b44a97e2aab274af400764"
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
