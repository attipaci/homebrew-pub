class Xchange < Formula
  desc "Structured data exchange and JSON support for C/C++"
  homepage "https://sigmyne.github.io/xchange/"
  url "https://github.com/Sigmyne/xchange/archive/refs/tags/v1.1.2-rc1.tar.gz"
  sha256 "40bc947e8123ac8bf3ab5da823e5e17e5bb6cefe941b3f121fb36dc2262f24af"
  license "Unlicense"
  head "https://github.com/Sigmyne/xchange.git", branch: "main"

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
