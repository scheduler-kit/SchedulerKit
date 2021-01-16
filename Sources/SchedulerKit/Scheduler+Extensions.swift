//
//  Scheduler+Extensions.swift
//
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation

public extension Scheduler {
    func eraseToAnyScheduler<S: Scheduler>() -> AnyScheduler<S> where S.SchedulerOptions == SchedulerOptions, S.SchedulerTimeType == SchedulerTimeType {
        AnyScheduler(scheduler: self)
    }
}
