class Swiftnes < Formula
    desc "NES emulator written in swift"
    homepage "https://github.com/takuyaohashi/SwiftNes"
    url "https://github.com/takuyaohashi/SwiftNes/archive/0.0.3.tar.gz"
    sha256 "1efe3cca9417ad7b44ef5476fad50b9c9fab5925fffc8293cdb3f3931dc0a2a3"
    def install
        system "make", "install", "PREFIX=#{prefix}"
    end

    depends_on :xcode
end
