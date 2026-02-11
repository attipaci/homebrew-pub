class Supernovas < Formula
  desc "High-precision C/C++ astrometry library"
  homepage "https://sigmyne.github.io/SuperNOVAS/"
  url "https://github.com/Sigmyne/SuperNOVAS/archive/refs/tags/v1.5.1.tar.gz"
  sha256 "6215121737b4d659c063d2c49a4a246c85d7ff2d6be3ef14adfcc3203bd35f9f"
  license "Unlicense"
  head "https://github.com/Sigmyne/SuperNOVAS.git", branch: "main"

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
