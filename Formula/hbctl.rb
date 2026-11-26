# typed: false
# frozen_string_literal: true

class Hbctl < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbctl"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.1/hbctl-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "c37d72fbca0f13a5dcb49094e52a46ef84a8aa104952e7b463018347c256e470"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.1/hbctl-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "d6c0021926ad98c8defa4ed1901ac69df91314ffdfffaa68b6357ab4108094c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.1/hbctl-0.1.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "74332c53a8d136cc1c06be729f9629aebbb85b1dd476cb68eb4a036f66b18808"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.1/hbctl-0.1.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2643629bb1cfc5a885c969d08abcde8f79c5ee33d5f65d32ff3783372fb6e9ca"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.1/hbctl-0.1.1-arm-unknown-linux-musleabi.tar.gz"
        sha256 "5fde5e8cfd010634f6c529d0ffa825bbe4b7d20278e16c52ee1421a439e3dc2e"
      else
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.1/hbctl-0.1.1-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "d3c356398c29b9e5cc954fd9cd99ea36a2591de221010675fe1eb472426ec07d"
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
