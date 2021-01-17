//
//  TestScheduler.swift
//  
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation
import SchedulerKit

open class TestScheduler: Scheduler {
    public typealias SchedulerTimeType = DispatchQueue.SchedulerTimeType
    public typealias SchedulerOptions = DispatchQueue.SchedulerOptions

    public init() {}

    /// Scheduler needs to be advanced before execution for delayed actions with interval
    public var enableImmediateExecutionIfPossible = true

    public func advance(by interval:  DispatchQueue.SchedulerTimeType.Stride) {
        _now = _now.advanced(by: interval)
    }

    public var _now: DispatchQueue.SchedulerTimeType = .init(.now())
    public var now: DispatchQueue.SchedulerTimeType { _now }

    public var _minimumTolerance: DispatchQueue.SchedulerTimeType.Stride = .zero
    public var minimumTolerance: DispatchQueue.SchedulerTimeType.Stride { _minimumTolerance }

    public var immediateActions: [ImmediateAction] = []
    public func schedule(options: DispatchQueue.SchedulerOptions?, _ action: @escaping () -> Void) {
        immediateActions.append(
            ImmediateAction(options: options, action: action)
        )

        if enableImmediateExecutionIfPossible {
            action()
        }
    }

    public var delayedActions: [DelayedAction] = []
    public func schedule(
        after: SchedulerTimeType,
        tolerance: SchedulerTimeType.Stride,
        options: SchedulerOptions?,
        _ action: @escaping () -> Void
    ) {
        delayedActions.append(
            DelayedAction(
                after: after,
                tolerance: tolerance,
                options: options,
                action: action
            )
        )

        if enableImmediateExecutionIfPossible {
            action()
        }
    }

    public var delayedIntervalActions: [DelayedIntervalAction] = []
    public func schedule(
        after: SchedulerTimeType,
        interval: SchedulerTimeType.Stride,
        tolerance: SchedulerTimeType.Stride,
        options : SchedulerOptions?,
        _ action: @escaping () -> Void
    ) -> Cancellable {
        let delayedIntervalAction = DelayedIntervalAction(
            after: after,
            interval: interval,
            tolerance: tolerance,
            options: options,
            action: action
        )
        delayedIntervalActions.append(delayedIntervalAction)
        return AnyCancellable { [weak self] in
            self?.delayedIntervalActions.removeAll(where: { $0.uuid == delayedIntervalAction.uuid })
        }
    }
}

public extension TestScheduler {
    struct ImmediateAction {
        fileprivate let uuid = UUID()

        public let options: DispatchQueue.SchedulerOptions?
        public let action: () -> Void
    }

    struct DelayedAction {
        fileprivate let uuid = UUID()

        public let after: SchedulerTimeType
        public let tolerance: SchedulerTimeType.Stride
        public let options: SchedulerOptions?
        public let action: () -> Void
    }

    struct DelayedIntervalAction {
        fileprivate let uuid = UUID()

        public let after: SchedulerTimeType
        public let interval: SchedulerTimeType.Stride
        public let tolerance: SchedulerTimeType.Stride
        public let options: SchedulerOptions?
        public let action: () -> Void
    }
}
