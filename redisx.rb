class Redisx < Formula
  desc "A free and independent Redis / Valkey client library for C/C++"
  homepage "https://sigmyne.github.io/redisx/"
  url "https://github.com/Sigmyne/redisx/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "7e87edf622dd0c6809bc52918962d5d5969475eca1ccc5a4fc4d899bf0746fb3"
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
  depends_on "attipaci/pub/xchange" => "1.2.0"
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
