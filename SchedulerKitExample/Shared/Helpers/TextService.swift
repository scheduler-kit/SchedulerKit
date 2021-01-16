//
//  TextService.swift
//  SchedulerKitExample (iOS)
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation

protocol TextServiceProtocol {
    func fetchText() -> AnyPublisher<String, Never>
}

class TextService: TextServiceProtocol {
    func fetchText() -> AnyPublisher<String, Never> {
        Deferred {
            Future { promise in
                DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
                    promise(.success("It works!"))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
