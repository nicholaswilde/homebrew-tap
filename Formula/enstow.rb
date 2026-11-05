# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.5/enstow-0.1.5-aarch64-apple-darwin.tar.gz"
      sha256 "05b09d44062835b17c26ce344a3528847b94dae520fd831605fe9a3a981cbeba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.5/enstow-0.1.5-x86_64-apple-darwin.tar.gz"
      sha256 "34ec541c75a88c0149e8854deb252e6cc44400d4e8deebb18c233da7e7756237"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.5/enstow-0.1.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8f6ff375d186dacbba5446f0a6d72defee00c7d63225a09d20a67eb7817b3586"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.5/enstow-0.1.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "133cf4e64d246439d0e0a23ed7793a960fdf2efb757a4094f4dd1d4574333f4f"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.5/enstow-0.1.5-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "ef2acd12b40c6fcabb14686f8da1be36b8fdc3f74aa51cf159d2a929006ea0e6"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.5/enstow-0.1.5-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "318c8e7c67cec484757a3ace61c3fe7c8b5ea2aab404fb7c3515e9b22d668569"
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
