import XCTest
@testable import SwiftNes

class NesFileTests: XCTestCase {
    func testNesFileInitializeNil() {
	let data = Data(bytes: [0, 1, 2, 4, 5])
        XCTAssertNil(NesFile(data))
    }

    static var allTests = [
        ("testNesFileInitializeNil", testNesFileInitializeNil),
    ]
}
