class Swiftnes < Formula
    desc "NES emulator written in swift"
    homepage "https://github.com/takuyaohashi/SwiftNes"
    url "https://github.com/takuyaohashi/SwiftNes/archive/0.0.2.tar.gz"
    sha256 "fc8820298a06285a5b9e9a67826758e77ddbaef7f0296ae97f23f80cdf6da3b8"
    def install
        system "make", "install", "PREFIX=#{prefix}"
    end

    depends_on :xcode
end
