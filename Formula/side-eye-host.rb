# typed: false
# frozen_string_literal: true

class SideEyeHost < Formula
  desc "USB Stat Monitor for Linux rig"
  homepage "https://github.com/nicholaswilde/side-eye"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.5/side-eye-host-0.2.5-aarch64-apple-darwin.tar.gz"
      sha256 "b090bbd789b465bf5bbda7fe361772869d02e38d61a30a06e778260f00328e60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.5/side-eye-host-0.2.5-x86_64-apple-darwin.tar.gz"
      sha256 "f957a0d05a40063b9f5f711db7b6552236822a6658cde983bcf5f359be30184f"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.5/side-eye-host-0.2.5-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3af1f0647495ffcdb724e5f58a0196b8b4fa85a439ebe51e47f8da31beae8dc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.5/side-eye-host-0.2.5-x86_64-unknown-linux-musl.tar.gz"
      sha256 "45ffd2cd7ad928339e628fa8b00d368e4167c5b19832ffcc871b1f1f1b7fefa0"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.2.5/side-eye-host-0.2.5-armv7-unknown-linux-musleabihf.tar.gz"
      sha256 "6749921510577945eb7e2a40b7d803af6ebb30628139462a52c63cd338d5971b"
    end
  end

  def install
    bin.install Dir["**/side-eye-host"].first
  end

  test do
    system "#{bin}/side-eye-host", "--help"
  end
end
