class Swiftnes < Formula
    desc "NES emulator written in swift"
    homepage "https://github.com/takuyaohashi/SwiftNes"
    url "https://github.com/takuyaohashi/SwiftNes/archive/0.0.2.tar.gz"
    sha256 "827436125d1ea1aa0e09f111100706ebbed5b5138c391a56668a096c5aca7fe6"
    def install
        system "make", "install", "PREFIX=#{prefix}"
    end

    depends_on :xcode
end
