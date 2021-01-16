import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(scheduler_kitTests.allTests),
    ]
}
#endif
