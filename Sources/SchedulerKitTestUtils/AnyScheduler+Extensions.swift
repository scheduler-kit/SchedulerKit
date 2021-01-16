//
//  AnyScheduler+Extensions.swift
//  
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation
import SchedulerKit

public extension AnyScheduler where S: DispatchQueue {
    static var test: AnyScheduler<DispatchQueue> {
        TestScheduler().eraseToAnyScheduler()
    }
}
