class Snowboard < Formula
  desc "API blueprint toolkit"
  homepage "https://github.com/bukalapak/snowboard"
  url "https://github.com/bukalapak/snowboard/releases/download/v1.1.0/snowboard-v1.1.0.darwin-amd64.tar.gz"
  version "1.1.0"
  sha256 "8277189ba335e424d25ce2efdd72126b8dd62bebf5c37754e88a087fa32581dd"

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
