//
//  ProfileView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some View {
        VStack(spacing: 20) {
            Text("👤 Profile")
                .font(.largeTitle)
                .bold()

            Text("Logged in as:")
                .font(.headline)
            Text(userEmail)
                .foregroundColor(.gray)

            Button(action: {
                // Clear user session
                userEmail = ""
                isLoggedIn = false
            }) {
                Text("🚪Log Out")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}
