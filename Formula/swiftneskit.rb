class Swiftneskit < Formula
  desc "NES emulator written in swift"
  homepage "https://github.com/takuyaohashi/SwiftNesKit"
  url "https://github.com/takuyaohashi/SwiftNesKit/archive/0.0.3.tar.gz"
  sha256 "b6f661cafa4b721cdb02e661b1c7f08876b2a950c37eac8a07ed6b41dd939cdd"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
