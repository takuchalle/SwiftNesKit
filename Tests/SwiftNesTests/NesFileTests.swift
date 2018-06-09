import XCTest
@testable import SwiftNesKit

class NesFileTests: XCTestCase {
    func testNesFileInitializeWithWrongHeader() {
        let fileName = "WrongHeader.nes"

        guard let data = openFile(with: fileName) else {
            XCTFail("Failed To Open Test File")
            return
        }
        
        XCTAssertNil(NesFile(data))
    }

    static var allTests = [
        ("testNesFileInitializeWithWrongHeader", testNesFileInitializeWithWrongHeader),
    ]
}
