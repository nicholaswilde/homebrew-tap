# typed: false
# frozen_string_literal: true

class Hbctl < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbctl"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.4/hbctl-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "866a690b2afb1a45130bbf22f117500e647272b94e948588a4e14a40718f6e16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.4/hbctl-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "e908de49827535c5c6aa71e6950ae400cff6ea65b859cf8d6a95de534fc0acbb"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.4/hbctl-0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3300b5b1453876fedcfea62b82d94e67d99b3640f6e708f584de4f55bfcbd321"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.4/hbctl-0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "02282570b95978519fd3c17a559ac841b28620124910835071882f7414547e1f"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.4/hbctl-0.1.4-arm-unknown-linux-musleabi.tar.gz"
        sha256 "cdf26578c3b486d0b1052bbd900685a25ca0d837374c48a8e1e17890af5c21fe"
      else
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.4/hbctl-0.1.4-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "8afb58e6d7b207b255441ec4c733d6185f687de68bce2f6e31f7e1320a254199"
      end
    end
  end

  def install
    bin.install Dir["**/hbctl"].first
  end

  test do
    system "#{bin}/hbctl", "--help"
  end
end
