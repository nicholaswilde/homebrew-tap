# typed: false
# frozen_string_literal: true

class Mdfm < Formula
  desc "Markdown frontmatter CLI: query, mutate, delete, and validate YAML and TOML"
  homepage "https://nicholaswilde.io/mdfm"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.2/mdfm-0.1.2-aarch64-apple-darwin.tar.gz"
      sha256 "f5465ea15a119fa5d33566285bf5ed7d648b8a49ec73e26c84e2faed47c06249"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.2/mdfm-0.1.2-x86_64-apple-darwin.tar.gz"
      sha256 "94aba0072ab5006a72d7af4d415937b797ccb93372ad0dc0cdce1b18c4041104"
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.2/mdfm-0.1.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "56f0cc8074fd3e09a0f0cd5eedf0942859a9d434c1f620960ee7298ee11f48af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.2/mdfm-0.1.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2f93b7e2420a455f9d9b53caf9fbc6ff32db78db59339d70a6af253722be50ae"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      if Utils.safe_popen_read("uname", "-m").include?("armv6")
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.2/mdfm-0.1.2-arm-unknown-linux-musleabi.tar.gz"
        sha256 "fcb7d5db01003068ea40ceb5d70628dc7730d3976aa2c47fe8140ad0541537ed"
      else
        url "https://github.com/nicholaswilde/mdfm/releases/download/v0.1.2/mdfm-0.1.2-armv7-unknown-linux-musleabihf.tar.gz"
        sha256 "8b3cb463fb7b7603ca7859b9e6b01a914a71d083c1b2dafcbbe2f8e8b3f19ad8"
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
