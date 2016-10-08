import XCTest
@testable import swift_onesignal

class swift_onesignalTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(swift_onesignal().text, "Hello, World!")
    }


    static var allTests : [(String, (swift_onesignalTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
