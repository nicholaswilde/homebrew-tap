# typed: false
# frozen_string_literal: true

class Enstow < Formula
  desc "📦 Secret-aware dotfile manager combining stow symlinking with sops and age decryption in Rust 🦀"
  homepage "https://github.com/nicholaswilde/enstow"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.7/enstow-0.1.7-aarch64-apple-darwin.tar.gz"
      sha256 "8a5af95e5c206abc369b42bf86c915281527ecf8815a7b37dd4f43d978b83f04"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.7/enstow-0.1.7-x86_64-apple-darwin.tar.gz"
      sha256 "d7e086aba40120f96702cbd4a34cd912672638a83d0546f68bec0d3ab7f30a7f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.7/enstow-0.1.7-aarch64-unknown-linux-musl.tar.gz"
      sha256 "039f37225145c37c9d2f6ddb119e1ccfc3216ff256ae3c4b5fb12269e2481f4e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.7/enstow-0.1.7-x86_64-unknown-linux-musl.tar.gz"
      sha256 "51484363ad7c87c75734af54d707e7c4a800f262df6cd46c3c180fbaa401adaf"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.7/enstow-0.1.7-arm-unknown-linux-gnueabihf.tar.gz"
        sha256 "ef42baad581f29852f69ff79d46ee5153faa326536d488e9c013c5802ccbe2be"
      else
        url "https://github.com/nicholaswilde/enstow/releases/download/v0.1.7/enstow-0.1.7-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "c05928530f4fa2a81de03cc1e7d115a2ca385f4ddb23cb88761e235d26d1491e"
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
