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
        // modelContainer(for:) crée le ModelContainer (la base de données) et le ModelContext.
        .modelContainer(for: [Task.self])
    }
}
