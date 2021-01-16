//
//  TextServiceMock.swift
//  SchedulerKitExampleTests
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation
@testable import SchedulerKitExample

class TextServiceMock: TextServiceProtocol {
    let fetchTextSubject = PassthroughSubject<String, Never>()
    func fetchText() -> AnyPublisher<String, Never> {
        fetchTextSubject.eraseToAnyPublisher()
    }
}
