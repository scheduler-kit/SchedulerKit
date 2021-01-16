//
//  SchedulerKitExampleApp.swift
//  Shared
//
//  Created by Gleb Radchenko on 16.01.21.
//

import SwiftUI

@main
struct SchedulerKitExampleApp: App {
    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView<TestableViewModel>()
                    .environmentObject(TestableViewModel())
                ContentView<NonTestableViewModel>()
                    .environmentObject(NonTestableViewModel())
            }
        }
    }
}
