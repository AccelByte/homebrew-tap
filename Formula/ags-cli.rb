class AgsCli < Formula
  desc "Unified CLI for AccelByte Gaming Services"
  homepage "https://accelbyte.io/gaming-services"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.1/accelbyte-ags-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9c7ff99b00feacae80acd45801d825a5a69fb438a44341f26e6e41257123780c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.1/accelbyte-ags-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c6ee5c87c033d3e21a656919711e2b33a7fa1e52cdede1d7781925d5599205a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.1/accelbyte-ags-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "edbdca75e52b0c8611f48e10f257011d3f3bd47ad867cb30fbcf367097df3b5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/AccelByte/accelbyte-ags-cli/releases/download/v0.5.1/accelbyte-ags-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d28778484071031019eb4fc21a91839d4f18cd79ac6610e828acde65d492c24b"
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
