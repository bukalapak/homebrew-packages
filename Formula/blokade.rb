class Blokade < Formula
  desc "simple proxy blocker"
  homepage "https://github.com/bukalapak/blokade"
  url "https://github.com/bukalapak/blokade/releases/download/v1.0.0/blokade-v1.0.0.darwin-amd64.tar.gz"
  version "1.0.0"
  sha256 "625f169bf84e8732a8da775308c65af0f59be9e00d63d9516b144b34eb282e77"

  def install
    bin.install "blokade"
  end

  test do
    system "#{bin}/blokade", "-h"
  end
end
