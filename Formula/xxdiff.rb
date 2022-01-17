class Xxdiff < Formula
  desc "xxdiff is a graphical file and directories comparator and merge tool."
  homepage "https://furius.ca/xxdiff/"
  url "https://downloads.sourceforge.net/project/xxdiff/xxdiff/4.0.1/xxdiff-4.0.1.tar.bz2"
  sha256 "bf58ddda9d7a887f4f5cae20070ed5f2e0d65f575af20860738c6e2742c3a000"
  license "BSD-2-Clause"

  # depends_on "cmake" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "./configure", *std_configure_args, "--disable-silent-rules"
    # system "cmake", "-S", ".", "-B", "build", *std_cmake_args
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test xxdiff`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
