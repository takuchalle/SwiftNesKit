import XCTest
@testable import SwiftNesKit

fileprivate let UNIT_SIZE = 8

class PatternTests: XCTestCase {
    func testReadPattern() {
        let upper : [UInt8] = [0x66, 0x7F, 0xFF, 0xFF, 0xFF, 0x7E, 0x3C, 0x18]
        let lower : [UInt8] = [0x66, 0x5F, 0xBF, 0xBF, 0xFF, 0x7E, 0x3C, 0x18]
        let pattern = Pattern.readPattern(upper, lower)

        let expect : [[UInt8]] = [
            [0, 3, 3, 0, 0, 3, 3, 0],
            [0, 3, 1, 3, 3, 3, 3, 3],
            [3, 1, 3, 3, 3, 3, 3, 3],
            [3, 1, 3, 3, 3, 3, 3, 3],
            [3, 3, 3, 3, 3, 3, 3, 3],
            [0, 3, 3, 3, 3, 3, 3, 0],
            [0, 0, 3, 3, 3, 3, 0, 0],
            [0, 0, 0, 3, 3, 0, 0, 0],
        ]

        for i in 0..<UNIT_SIZE {
            for j in 0..<UNIT_SIZE {
                XCTAssert(expect[i][j] == pattern.data[i][j])
            }
        }
    }

    static var allTests = [
        ("testReadPattern", testReadPattern),
    ]
}
