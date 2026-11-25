# typed: false
# frozen_string_literal: true

class Mdfm < Formula
  desc "Markdown frontmatter CLI: query, mutate, delete, and validate YAML and TOML"
  homepage "https://nicholaswilde.io/mdfm"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.3/mdfm-0.1.3-aarch64-apple-darwin.tar.gz"
      sha256 "1d6bc6c46c5814bc470ce92ced88600a3f1edb196db7981180e741e221386f2c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.3/mdfm-0.1.3-x86_64-apple-darwin.tar.gz"
      sha256 "5fdba7e30d1af77a1747abe90b939cf19ac189dfc38e034bdd14851df34cafd7"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.3/mdfm-0.1.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "c37aa77dd507eac05b34bd8f45c6bbdbf2c42e09378e2846e71859496a062ee4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.3/mdfm-0.1.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3766f2366aa7e80ef87cf9a1bf110f00a9c7385540372f46932cac7a4f5d7ab5"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.3/mdfm-0.1.3-arm-unknown-linux-musleabi.tar.gz"
        sha256 "d0c0e2491169709f03275b4c50cfe3f31f721d2035f2806a535e3afcd74c292e"
      else
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.3/mdfm-0.1.3-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "1f02bb876f50bdb42119b7dad84920b0fd2b058b35d4ba537afaea7b28622ec5"
      end
    end
  end

  def install
    bin.install Dir["**/mdfm"].first
  end

  test do
    system bin/"mdfm", "--help"
  end
end
