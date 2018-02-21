import XCTest
@testable import SwiftNes

class SwiftNesTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftNes().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
