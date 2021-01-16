//
//  ViewModelProtocol.swift
//  SchedulerKitExample (iOS)
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Foundation

protocol ViewModelProtocol {
    var text: String? { get }

    func handleViewAppear()
}
