# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class CookDocs < Formula
  desc "A tool for automatically generating markdown documentation for cooklang recipes"
  homepage "https://nicholaswilde.io/cook-docs"
  version "0.2.4"
  license "Apache License 2.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.2.4/cook-docs_0.2.4_Darwin_x86_64.tar.gz"
      sha256 "14f426b65c738abeda48e15985a1d939abbd65fee2aacde2e9f0bac7fbe45c37"

      def install
        bin.install "cook-docs"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.2.4/cook-docs_0.2.4_Darwin_arm64.tar.gz"
      sha256 "aab862142f2dcfd56de16f0271486d7f018e978711b48cd845439d57fb9e06c2"

      def install
        bin.install "cook-docs"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.2.4/cook-docs_0.2.4_Linux_armv6.tar.gz"
      sha256 "455cebd34a2bd7bad3c151f8828ec406e38538fdf92d62a164374a7f7454e177"

      def install
        bin.install "cook-docs"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.2.4/cook-docs_0.2.4_Linux_arm64.tar.gz"
      sha256 "d5410e24872c182e4c49cd68eed6bb80da044b6f6d710f93200a21ab02b79084"

      def install
        bin.install "cook-docs"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/nicholaswilde/cook-docs/releases/download/v0.2.4/cook-docs_0.2.4_Linux_x86_64.tar.gz"
      sha256 "b4f52a6d550df74ce49365b4597d8b7b79b0cadccccbb099628ca887611947cf"

      def install
        bin.install "cook-docs"
      end
    end
  end

  test do
    system "#{bin}/cook-docs --version"
  end
end
