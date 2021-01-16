//
//  NonTestableViewModelTests.swift
//  Tests iOS
//
//  Created by Gleb Radchenko on 16.01.21.
//

import XCTest
@testable import SchedulerKitExample
import Combine

class NonTestableViewModelTests: XCTestCase {
    let mockTextService = TextServiceMock()

    var sut: NonTestableViewModel!

    override func setUp() {
        super.setUp()
        sut = .init(textService: mockTextService)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_text_onInit() {
        XCTAssertNil(sut.text)
    }

    func test_text_after_viewAppear() {
        // when
        sut.handleViewAppear()

        // then
        XCTAssertNil(sut.text)

        // when
        mockTextService.fetchTextSubject.send("fake")

        // then
        let expectation = self.expectation(description: "text expectation")
        DispatchQueue.main.async {
            // assuming we know that this code will be executed after .receive(on: DispatchQueue.main)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.3)

        XCTAssertEqual(sut.text, "fake")
    }
}
