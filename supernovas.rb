class Supernovas < Formula
  desc "High-precision C/C++ astrometry library"
  homepage "https://smithsonian.github.io/SuperNOVAS/"
  url "https://github.com/Smithsonian/SuperNOVAS/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "b42e57ccccc46f1a5c5532465dd68abbe6abcd662b99d289491e2887afdd0cca"
  license "Unlicense"
  head "https://github.com/Smithsonian/SuperNOVAS.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "cmake" => :build
  depends_on "calceph"

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DENABLE_CALCEPH=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
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
