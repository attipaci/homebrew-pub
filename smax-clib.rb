class SmaxClib < Formula
  desc "A free C/C++ client library and toolkit for the SMA Exchange (SMA-X) structured real-time database"
  homepage "https://sigmyne.github.io/smax-clib/"
  url "https://github.com/Sigmyne/smax-clib/archive/refs/tags/v1.1.0-rc1.tar.gz"
  sha256 "4602c6b03dc58a99ee90023b271d68b7f9bf156081dfea1925e46b1e688a8477"
  license "Unlicense"
  head "https://github.com/Sigmyne/smax-clib.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  option "with-tls", "Compile with TLS support"
  option "with-libomp", "Compile with OpenMP support for parallel cluster operations."
  option "with-doxygen", "Compile HTML documentation with Doxygen"

  depends_on "cmake" => :build
  depends_on "attipaci/pub/redisx" => "1.1.0"
  depends_on "attipaci/pub/xchange" => "1.3.0"
  depends_on "popt"
  depends_on "readline"
  depends_on "libbsd"
  depends_on "openssl" => :recommended
  depends_on "doxygen" => :optional

  def install
    
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_CLI=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
   
    args << "-DENABLE_TLS=ON" if not build.without? "openssl" 
    args << "-DBUILD_DOC=ON" if build.with? "doxygen" 
 
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "smaxValue --help"
  end
end
