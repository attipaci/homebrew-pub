class Xchange < Formula
  desc "Structured data exchange and JSON support for C/C++"
  homepage "https://sigmyne.github.io/xchange/"
  url "https://github.com/Sigmyne/xchange/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "34cc98fdc630f3592443b605ed725fb02c642075d4cb3c227c22f5e37c443367"
  license "Unlicense"
  head "https://github.com/Sigmyne/xchange.git", branch: "main"

  # Patches from upstream commits after 1.2.0 release.
  # 1. Add xIsDebug()
  patch do
    url "file://#{__dir__}/patches/xchange-1.2.0-0001.patch"
    sha256 "ee9960c6b6560ceab4a3b56dc873d0959032a54e81e65d22b1c31ca362a21f32"
  end

  # 2. Remove checkis for math lib in package config
  patch do
    url "file://#{__dir__}/patches/xchange-1.2.0-0002.patch"
    sha256 "6974ca5e605cad72f6dc430bea493ad7773f1f62c18e6bb39b0c4c42755302a8"
  end
  
  # 3. Changelog updates for the above two patches
  patch do
    url "file://#{__dir__}/patches/xchange-1.2.0-0003.patch"
    sha256 "7a0f1289a63ebcc90d176e03d65043b76797185dacdcc9e5973732a18b7c5713"
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :optional

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    
    args << "-DBUILD_DOC=ON" if build.with? "doxygen" 
 
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"testxchange.c").write <<~C
      #include <xchange.h>
      #include <assert.h>

      int main () {
        double dpsi, deps;
        int ret = xParseBoolean("true", 0);
        assert (ret == 1);
        return 0;
      }
    C
    system ENV.cc, "testxchange.c", "-L#{lib}", "-lxchange", "-o", "testxchange"
    system "./testxchange"
  end
end

__END__

