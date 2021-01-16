//
//  TestableViewModelTests.swift
//  Tests iOS
//
//  Created by Gleb Radchenko on 16.01.21.
//

import XCTest
@testable import SchedulerKitExample
import Combine
import SchedulerKitTestUtils
import SchedulerKit

class TestableViewModelTests: XCTestCase {
    let mockTextService = TextServiceMock()
    let scheduler: TestScheduler = .init()

    var sut: TestableViewModel!

    override func setUp() {
        super.setUp()
        sut = .init(scheduler: scheduler.eraseToAnyScheduler(), textService: mockTextService)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_text_onInit() {
        XCTAssertNil(sut.text)
        XCTAssertEqual(scheduler.immediateAction.count, 0)
        XCTAssertEqual(scheduler.delayedActions.count, 0)
        XCTAssertEqual(scheduler.delayedIntervalActions.count, 0)
    }

    func test_text_after_viewAppear() {
        // when
        sut.handleViewAppear()

        // then
        XCTAssertNil(sut.text)
        XCTAssertEqual(scheduler.immediateAction.count, 0) // just an example, can be avoided in real tests

        // when
        mockTextService.fetchTextSubject.send("fake")

        // then
        XCTAssertEqual(sut.text, "fake")
        XCTAssertEqual(scheduler.immediateAction.count, 1)
    }
}
