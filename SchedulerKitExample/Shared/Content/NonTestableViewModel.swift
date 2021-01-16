//
//  NonTestableViewModel.swift
//  SchedulerKitExample (iOS)
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import Foundation
import SchedulerKit

class NonTestableViewModel: ViewModelProtocol, ObservableObject {
    @Published var text: String?

    private let textService: TextServiceProtocol

    private var subscriptions: Set<AnyCancellable> = []

    init(textService: TextServiceProtocol = TextService()) {
        self.textService = textService
    }

    func handleViewAppear() {
        fetchText()
    }

    // MARK: - Private
    private func fetchText() {
        textService.fetchText()
            .receive(on: DispatchQueue.main)
            .map { $0 as Optional<String> }
            .assign(to: \.text, on: self)
            .store(in: &subscriptions)
    }
}
