class AgsCli < Formula
  desc "Unified CLI for AccelByte Gaming Services"
  homepage "https://accelbyte.io/gaming-services"
  version "0.5.0-rc.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.2/accelbyte-ags-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d804cc8b6b39238201b2e2125093a761439edfee58baf99d8f01177a3d646d03"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.2/accelbyte-ags-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a9ec93bb72d8db3cc05eb02c7e8ae5af3a677836f85442b7b528e534da9797f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.2/accelbyte-ags-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "189751487df04afcf0047a2bc4e8a556aaa92da51228107dfc0ab6c76fcceadb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.2/accelbyte-ags-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "09098659c09e893a263549763e25e72561e5255a844f3c68232676b17513e7ff"
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
