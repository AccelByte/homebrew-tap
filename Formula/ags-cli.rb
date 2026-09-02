class AgsCli < Formula
  desc "Unified CLI for AccelByte Gaming Services"
  homepage "https://accelbyte.io/gaming-services"
  version "0.5.0-rc.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.1/accelbyte-ags-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a9481acd2acfeeddd2725001e2158dda5312ab25e1ede68679ade5093c46ff3a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.1/accelbyte-ags-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5a389c89603002b9e68c80aa7d8c2c60062db7c0973ab85563a0249cb7ae46e9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.1/accelbyte-ags-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d2b81c98ad611111c187c410a732e7640e15f76b8a61ce85972b89649711e3fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.0-rc.1/accelbyte-ags-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "32399dfcd143c9cb0692bd66beb2a259f20b6c3bb4f6a264d54e216f2c489a25"
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
