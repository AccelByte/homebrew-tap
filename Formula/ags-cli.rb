class AgsCli < Formula
  desc "Unified CLI for AccelByte Gaming Services"
  homepage "https://accelbyte.io/gaming-services"
  version "0.5.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.2/accelbyte-ags-cli-aarch64-apple-darwin.tar.xz"
      sha256 "db79af76cd6af123c7217a13b2e1b79cf388c56f892817c00f172c549b3032c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.2/accelbyte-ags-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4de1d7fe72e61901ecc3a4635b12075c4ee8d0eda6fab7f03d97c13c71c9cf06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.2/accelbyte-ags-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "11bd5ff82783890c3310ed1618c0a7792f1c0463bcec5471e6ced576b70d0122"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.2/accelbyte-ags-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "acb638fa8484f4c52193b43714838b200d522b4d239c4bc3656cb1c006d15a49"
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
