class Crush < Formula
  desc "Data reduction and imaging pipeline for select astronomical cameras"
  homepage "https://www.sigmyne.com/crush"
  url "https://github.com/attipaci/crush/releases/download/2.50-2/crush-2.50-2.tar.gz"
  sha256 "69a400e17dd5713df55df13950481166dc7c095411f5f9fc9c9e522a92fbbd2e"

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
    bin.install_symlink "#{pkgshare}/difftool"
    bin.install_symlink "#{pkgshare}/imagetool"
    bin.install_symlink "#{pkgshare}/show"
  end

  test do
    system "#{bin}/crush"
  end
end
