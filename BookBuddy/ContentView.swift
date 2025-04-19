//
//  ContentView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @State private var showToast = false
    @State private var toastMessage = ""


    var body: some View {
        if isLoggedIn {
            TabView {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "book")
                    }

                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }

                ProfileView() // 👤 Show user profile + log out
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        } else {
            LoginView() // 🔐 Show login/registration screen
        }
    }
}
