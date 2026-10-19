class AgsCli < Formula
  desc "Unified CLI for AccelByte Gaming Services"
  homepage "https://accelbyte.io/gaming-services"
  version "0.5.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.3/accelbyte-ags-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b4b80a21ffad2bb833860ade0dcd70b1139d1baca7cbf6dae5f03e6e543637c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.3/accelbyte-ags-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cb4c7d5a668e8ffc19617f992144819375d20959bb6073417e2e1395ebc2ebab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.3/accelbyte-ags-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e816c0c207f8cd2a98315fe5dc97466150d5b32fe9bcdb9676ddd86f8b48a427"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.3/accelbyte-ags-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ce6f9862cbb9b85c696a434594f8ba49de0a23e59571b00ca7b35c99ad5e7cc4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "ags"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ags"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ags"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ags"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
