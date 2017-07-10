class Snowboard < Formula
  desc "API blueprint parser and renderer"
  homepage "https://github.com/bukalapak/snowboard"
  url "https://github.com/bukalapak/snowboard/releases/download/v0.6.4/snowboard-v0.6.4.darwin-amd64.tar.gz"
  version "0.6.4"
  sha256 "24b455a14b23d3e010c1146f56e25b083d3542193f6af08dc86a507b71276802"

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
