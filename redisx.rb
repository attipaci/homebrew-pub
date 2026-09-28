class Redisx < Formula
  desc "A free and independent Redis / Valkey client library for C/C++"
  homepage "https://sigmyne.github.io/redisx/"
  url "https://github.com/Sigmyne/redisx/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "d8d2e00039c82b7770f680059e23d2bccd3be6d11e8b25db39c10aa8ab72cf71"
  license "Unlicense"
  head "https://github.com/Sigmyne/redisx.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  option "with-tls", "Compile with TLS support"
  option "with-libomp", "Compile with OpenMP support for parallel cluster operations."
  option "with-doxygen", "Compile HTML documentation with Doxygen"

  depends_on "cmake" => :build
  depends_on "attipaci/pub/xchange" => "1.3.0"
  depends_on "popt"
  depends_on "readline"
  depends_on "libbsd"
  depends_on "openssl" => :recommended
  depends_on "libomp" => :recommended
  depends_on "doxygen" => :optional

  def install
    
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_CLI=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
   
    args << "-DENABLE_TLS=ON" if not build.without? "openssl" 
    args << "-DENABLE_OPENMP=ON" if not build.without? "libomp"
    args << "-DBUILD_DOC=ON" if build.with? "doxygen" 
 
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system "redisx-cli --help"
  end
end
