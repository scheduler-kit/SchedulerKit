//
//  TestableViewModel.swift
//  SchedulerKitExample (iOS)
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation
import SchedulerKit

class TestableViewModel: ViewModelProtocol, ObservableObject {
    @Published var text: String?

    private let textService: TextServiceProtocol

    private let scheduler: DispatchQueueAnyScheduler
    private var subscriptions: Set<AnyCancellable> = []

    init(
        scheduler: DispatchQueueAnyScheduler = .main,
        textService: TextServiceProtocol = TextService()
    ) {
        self.scheduler = scheduler
        self.textService = textService
    }

    func handleViewAppear() {
        fetchText()
    }

    // MARK: - Private
    private func fetchText() {
        textService.fetchText()
            .receive(on: scheduler)
            .map { $0 as Optional<String> }
            .assign(to: \.text, on: self)
            .store(in: &subscriptions)
    }
}
