//
//  AnyScheduler.swift
//  
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation

open class AnyScheduler<S: Scheduler>: AnySchedulerBase<S.SchedulerTimeType, S.SchedulerOptions> {}
public typealias DispatchQueueAnyScheduler = AnyScheduler<DispatchQueue>

/// Type erasure for Combine's Scheduler
open class AnySchedulerBase<Time: Strideable, Options>: Scheduler where Time.Stride: SchedulerTimeIntervalConvertible {
    public typealias SchedulerTimeType = Time
    public typealias SchedulerOptions = Options

    private var _now: () -> Time
    public var now: Time { _now() }

    private var _minimumTolerance: () -> Time.Stride
    public var minimumTolerance: Time.Stride { _minimumTolerance() }

    private var _schedule: (_ options: Options?, _ action: @escaping () -> Void) -> Void
    public func schedule(options: Options?, _ action: @escaping () -> Void) {
        _schedule(options, action)
    }

    private var _scheduleAfter: (_ date: Time, _ tolerance: Time.Stride, _ options: SchedulerOptions?, _ action: @escaping () -> Void) -> Void
    public func schedule(after date: Time, tolerance: Time.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) {
        _scheduleAfter(date, tolerance, options, action)
    }

    private var _scheduleAfterCancellable: (_ date: SchedulerTimeType, _ interval: SchedulerTimeType.Stride, _ tolerance: SchedulerTimeType.Stride, _ options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable
    public func schedule(after date: SchedulerTimeType, interval: SchedulerTimeType.Stride, tolerance: SchedulerTimeType.Stride, options: SchedulerOptions?, _ action: @escaping () -> Void) -> Cancellable {
        _scheduleAfterCancellable(date, interval, tolerance, options, action)
    }

    public init<S: Scheduler>(scheduler: S) where S.SchedulerTimeType == Time, S.SchedulerOptions == Options {
        _now = { scheduler.now }
        _minimumTolerance = { scheduler.minimumTolerance }
        _schedule = { options, action in scheduler.schedule(options: options, action) }
        _scheduleAfter = { date, tolerance, options, action in
            scheduler.schedule(after: date, tolerance: tolerance, options: options, action)
        }
        _scheduleAfterCancellable = { date, interval, tolerance, options, action in
            scheduler.schedule(after: date, interval: interval, tolerance: tolerance, options: options, action)
        }
    }
}
