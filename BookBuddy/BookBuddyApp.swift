//
//  BookBuddyApp.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI

@main
struct BookBuddyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
