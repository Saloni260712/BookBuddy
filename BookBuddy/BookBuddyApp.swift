//
//  BookBuddyApp.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI
import Firebase


@main
struct BookBuddyApp: App {
    let persistenceController = PersistenceController.shared

    init() {
            FirebaseApp.configure() 
        }

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
    }
}
