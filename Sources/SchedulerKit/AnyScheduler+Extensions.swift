//
//  AnyScheduler+Extensions.swift
//  
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation

public extension AnyScheduler where S: DispatchQueue {
    static var main: AnyScheduler<DispatchQueue> {
        DispatchQueue.main.eraseToAnyScheduler()
    }

    static func global(qos: DispatchQoS.QoSClass = .default) -> AnyScheduler<DispatchQueue> {
        DispatchQueue.global(qos: qos).eraseToAnyScheduler()
    }
}
