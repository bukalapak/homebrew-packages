class Snowboard < Formula
  desc "API blueprint toolkit"
  homepage "https://github.com/bukalapak/snowboard"
  url "https://github.com/bukalapak/snowboard/releases/download/v1.4.0/snowboard-v1.4.0.darwin-amd64.tar.gz"
  version "1.4.0"
  sha256 "3d8465f37e0df578bae4ca955a0099d1963ff230cb203ffbbb7a8590ad7857c8"

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
