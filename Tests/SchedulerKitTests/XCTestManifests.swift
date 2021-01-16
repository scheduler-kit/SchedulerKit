import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SchedulerKitTests.allTests),
    ]
}
#endif
