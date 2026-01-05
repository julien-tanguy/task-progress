//
//  Task_ProgressApp.swift
//  Task Progress
//
//  Created by julien tanguy on 04/01/2026.
//

import SwiftUI
import SwiftData

@main
struct Task_ProgressApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // modelContainer(for:) crée la base de données SwiftData automatiquement.
        .modelContainer(for: [Task.self])
    }
}
