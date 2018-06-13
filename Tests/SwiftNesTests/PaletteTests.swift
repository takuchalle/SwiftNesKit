import XCTest
@testable import SwiftNesKit

class PaletteTests: XCTestCase {
    func testPalette() {
        let data: [UInt8] = [0x0F, 0x21, 0x34, 0x3D]
        let expect: [XColor] = [
            XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x0F
            XColor.init(red: 0x6D, green: 0xB6, blue: 0xFF), // 0x21
            XColor.init(red: 0xFF, green: 0x91, blue: 0xFF), // 0x34
            XColor.init(red: 0x00, green: 0x00, blue: 0x00), // 0x3D
        ]
        let palette = Palette.read(data)
        
        for (index, color) in palette.enumerated() {
            XCTAssert(color.isEqual(expect[index]))
        }
    }

    static var allTests = [
        ("testPalette", testPalette),
    ]
}
