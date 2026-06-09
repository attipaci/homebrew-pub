class Xchange < Formula
  desc "Structured data exchange and JSON support for C/C++"
  homepage "https://sigmyne.github.io/xchange/"
  url "https://github.com/Sigmyne/xchange/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "34cc98fdc630f3592443b605ed725fb02c642075d4cb3c227c22f5e37c443367"
  license "Unlicense"
  head do
    url "https://github.com/Sigmyne/xchange.git", branch: "main"

    patch do
      url "https://github.com/attipaci/homebrew-pub/blob/master/xchange-1.2.0-0001.patch"
    end
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
