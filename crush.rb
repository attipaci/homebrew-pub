class Crush < Formula
  desc "Data reduction and imaging pipeline for select astronomical cameras"
  homepage "https://www.sigmyne.com/crush"
  url "https://github.com/attipaci/crush/releases/download/2.50-2/crush-2.50-2.tar.gz"
  sha256 "e8f14bd924b89b155664b5f287c8b7ecc4ed4510e3bc6fa39150f503cd6dec81"

  bottle :unneeded

  depends_on ":java" => "1.8+"
  depends_on "gnuplot" => :recommended

  def install
    # Install the various bits and pieces to their proper locations
    share.install Dir["Install/posix/share/*"]
    man.install Dir["Install/posix/man/*"]
    doc.install Dir["Documentation/*"]
    doc.install ["copyright", "license.txt"]

    # Delete files installed elsewhere from #{pkgshare}
    rm_rf "Install"
    rm_rf "Documentation"
    rm_f "copyright"
    rm_f "license"

    # Copy the rest of the distro into its final location in #{prefix}/share/crush
    pkgshare.install Dir["*"]

    # Create symlinks to the executables in #{bin}
    bin.install_symlink "#{pkgshare}/crush"
    bin.install_symlink "#{pkgshare}/coadd"
    bin.install_symlink "#{pkgshare}/detect"
    bin.install_symlink "#{pkgshare}/esorename"
    bin.install_symlink "#{pkgshare}/histogram"
    bin.install_symlink "#{pkgshare}/difference"
    bin.install_symlink "#{pkgshare}/imagetool"
    bin.install_symlink "#{pkgshare}/show"
  end

  test do
    system "#{bin}/crush"
  end
end
