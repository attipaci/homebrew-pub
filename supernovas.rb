class Supernovas < Formula
  desc "High-precision C/C++ astrometry library"
  homepage "https://sigmyne.github.io/SuperNOVAS/"
  url "https://github.com/Sigmyne/SuperNOVAS/archive/refs/tags/v1.6.0.tar.gz"
  sha256 "c6dcfcc641c2406b4d5d57e7e946e9cb83b55442c10e694a440e7a9646115241"
  license "Unlicense"
  head "https://github.com/Sigmyne/SuperNOVAS.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  option "without-c++", "Compile without C++ API support"
  option "without-calceph", "Compile without CALCEPH bindings"
  option "with-cspice", "Compile with NAIF CSPICE support"
  option "with-doxygen", "Compile HTML documentation with Doxygen"

  depends_on "cmake" => :build
  depends_on "calceph" => :recommended
  depends_on "cspice" => :optional
  depends_on "doxygen" => :optional

  def install
    
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
   
    args << "-DENABLE_CPP=ON" if not build.without? "c++" 
    args << "-DENABLE_CALCEPH=ON" if not build.without? "calceph"
    args << "-DENABLE_CSPICE=ON" if build.with? "cspice" 
    args << "-DBUILD_DOC=ON" if build.with? "doxygen" 
 
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"testsupernovas.c").write <<~C
      #include <novas.h>
      #include <assert.h>

      int main () {
        double dpsi, deps;
        int ret = nutation_angles(NOVAS_JD_J2000, NOVAS_FULL_ACCURACY, &dpsi, &deps);
        assert (ret == 0);
        return 0;
      }
    C
    system ENV.cc, "testsupernovas.c", "-L#{lib}", "-lsupernovas", "-o", "testsupernovas"
    system "./testsupernovas"
  end
end
