# typed: false
# frozen_string_literal: true

class Hbctl < Formula
  desc "Fast, agent-friendly Rust CLI for remote Homebox v0.26+ instances"
  homepage "https://github.com/nicholaswilde/hbctl"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.6/hbctl-0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "548eda4c8c23f58fd39918c574f885a32624e3eb1e15a7751cf82dc3a894aef6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.6/hbctl-0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "5b99bdff20009001d761769f5190d24d96f895abac7a1e519899231563b779c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.6/hbctl-0.1.6-aarch64-unknown-linux-musl.tar.gz"
      sha256 "fca61e156b6af46a157a6d2e01f0c86295cbfdafc672b057cf56af151b1d3279"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.6/hbctl-0.1.6-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f615a02476c7a82f0c0fb2ac4a576dabd4560706c3775c581ccfa0a01a1c8f73"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.6/hbctl-0.1.6-arm-unknown-linux-musleabi.tar.gz"
        sha256 "c0a1f21a6313d1c08d9c75b8cbfe301f7eb1f5d38ea711010b6f9e9d4a3fcffb"
      else
        url "https://github.com/nicholaswilde/hbctl/releases/download/v0.1.6/hbctl-0.1.6-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "b3035a1841153f5bb58724257dd621a9af43ae18633c44e27fd59cf7f9a944cf"
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
