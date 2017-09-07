class Snowboard < Formula
  desc "API blueprint toolkit"
  homepage "https://github.com/bukalapak/snowboard"
  url "https://github.com/bukalapak/snowboard/releases/download/v0.6.7/snowboard-v0.6.7.darwin-amd64.tar.gz"
  version "1.0.0"
  sha256 "b154026fc945849c09a32a9ab27fe45d20bfd23f8dc3138b277c843257991c74"

  head do
    url "https://github.com/bukalapak/snowboard.git"
    depends_on "go" => :build
  end

  def install
    if build.head?
      ENV["GOPATH"] = buildpath
      ENV.prepend_create_path "PATH", buildpath / "bin"

      pkgpath = buildpath / "src/github.com/bukalapak/snowboard"
      pkgpath.install Dir["*"]

      cd pkgpath do
        system "make", "submodules"
        system "make", "drafter"
        system "make", "go-gen"
        system "make", "go-build"
        bin.install "snowboard"
      end
    else
      bin.install "snowboard"
    end
  end

  test do
    system "#{bin}/snowboard", "-v"
  end
end
