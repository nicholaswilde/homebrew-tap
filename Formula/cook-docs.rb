# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class CookDocs < Formula
  desc "A tool for automatically generating markdown documentation for cooklang recipes"
  homepage "https://nicholaswilde.io/cook-docs"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.8.0/cook-docs_0.8.0_Darwin_arm64.tar.gz"
      sha256 "b2da52ba38856935b414e85c549a2ca5e371d49feb91aaf609fe3479f200677d"

      def install
        bin.install "cook-docs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.8.0/cook-docs_0.8.0_Darwin_x86_64.tar.gz"
      sha256 "309c8ea3e6e76e2a3bad94826b75f3e0f8d969bf42d7c7382c0dcf912e81f853"

      def install
        bin.install "cook-docs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.8.0/cook-docs_0.8.0_Linux_arm64.tar.gz"
      sha256 "4293214915e1ff5b6c1bda7f74fdc3f1295fb97715998d54a393e7c6854a8bf0"

      def install
        bin.install "cook-docs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.8.0/cook-docs_0.8.0_Linux_x86_64.tar.gz"
      sha256 "eab858695735cb176e5ff9a53a9845da5d412dad8181e4cd7a6eb26ff1cf7dfb"

      def install
        bin.install "cook-docs"
      end
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.8.0/cook-docs_0.8.0_Linux_armv6.tar.gz"
      sha256 "dc1e7aa86a12ccef3083834b7b48cf6ffaad9b02fc14611f47d1e76c5b9671eb"

      def install
        bin.install "cook-docs"
      end
    end
  end

  test do
    system "#{bin}/cook-docs --version"
  end
end
