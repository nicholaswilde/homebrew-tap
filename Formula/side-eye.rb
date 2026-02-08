# typed: false
# frozen_string_literal: true

class SideEye < Formula
  desc "USB Stat Monitor for Linux rig"
  homepage "https://github.com/nicholaswilde/side-eye"
  version "0.1.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.1.4/side-eye-host-0.1.4-aarch64-apple-darwin.tar.gz"
      sha256 "e2df14e08a2f8a4dcab1825e9bdc3ac734a30e95894e331018d4e49f129710cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.1.4/side-eye-host-0.1.4-x86_64-apple-darwin.tar.gz"
      sha256 "4604ee9014699b3932c9d81a7c58e88939e9c7da5eac3eb7539d4b29d0edf8d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.1.4/side-eye-host-0.1.4-aarch64-unknown-linux-musl.tar.gz"
      sha256 "558cb31108afdfff6127d91e684501f1fd8bb75f094fc9ccf314b712de3fb6ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.1.4/side-eye-host-0.1.4-x86_64-unknown-linux-musl.tar.gz"
      sha256 "76e2888f8dc7ff2205d832be9e58416d4d99534c018e5c814faf57e4ee018cdd"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/side-eye/releases/download/v0.1.4/side-eye-host-0.1.4-armv7-unknown-linux-musleabihf.tar.gz"
      sha256 "021f276ee129a02b4cdb618249b5f0c69c47d5ad265e8f90b755db2d5d76d36c"
    end
  end

  def install
    cpu = if Hardware::CPU.arm?
      Hardware::CPU.is_64_bit? ? "aarch64" : "armv7"
    else
      "x86_64"
    end
    os = OS.mac? ? "apple-darwin" : "unknown-linux-musl"
    os = "unknown-linux-musleabihf" if !Hardware::CPU.is_64_bit? && OS.linux? && Hardware::CPU.arm?

    dir = "side-eye-host-#{version}-#{cpu}-#{os}"
    bin.install "#{dir}/side-eye-host" => "side-eye"
  end

  test do
    system "#{bin}/side-eye", "--version"
  end
end
