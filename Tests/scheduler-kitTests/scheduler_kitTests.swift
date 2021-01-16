import XCTest
@testable import scheduler_kit

final class scheduler_kitTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(scheduler_kit().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
