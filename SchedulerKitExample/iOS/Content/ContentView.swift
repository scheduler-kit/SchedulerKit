//
//  ContentView.swift
//  Shared
//
//  Created by Gleb Radchenko on 16.01.21.
//

import Combine
import SwiftUI

struct ContentView<ViewModel: ViewModelProtocol & ObservableObject>: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        Text(viewModel.text ?? "Loading...")
            .padding()
            .onAppear(perform: viewModel.handleViewAppear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView<DummyViewModel>()
            .environmentObject(DummyViewModel())
    }

    class DummyViewModel: ViewModelProtocol, ObservableObject {
        @Published var text: String?
        func handleViewAppear() {}
    }
}
