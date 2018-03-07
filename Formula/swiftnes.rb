class Swiftnes < Formula
    desc "NES emulator written in swift"
    homepage "https://github.com/takuyaohashi/SwiftNes"
    url "https://github.com/takuyaohashi/SwiftNes/archive/0.0.1.tar.gz"
    sha256 "368d11dd35a1da123413560adf741439484db6ce4bbee78653eab843bd57a200"
    def install
        system "make", "install", "PREFIX=#{prefix}"
    end

    depends_on :xcode
end
