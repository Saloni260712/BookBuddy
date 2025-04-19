//
//  LoginView.swift
//  BookBuddy
//
//  Created by Meet Patel on 18/04/25.
//

import SwiftUI
import Firebase
import FirebaseAuth


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @State private var error = ""
   
    @AppStorage("userEmail") var userEmail = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false
    var body: some View {
        
        VStack(spacing: 20) {
                    Text(isRegistering ? "Register" : "Login")
                        .font(.largeTitle).bold()

                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .textFieldStyle(.roundedBorder)

                    SecureField("Password", text: $password)
                        .textFieldStyle(.roundedBorder)

                    if !error.isEmpty {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Button(action: {
                        isRegistering ? register() : login()
                    }) {
                        Text(isRegistering ? "Register" : "Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    Button(action: {
                        isRegistering.toggle()
                    }) {
                        Text(isRegistering ? "Already have an account? Log in" : "No account? Register")
                            .font(.caption)
                    }
                }
                .padding()
            }
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let err = error {
                print("Firebase registration error: \(err.localizedDescription)")
            } else {
                userEmail = email
                isLoggedIn = true
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let err = error {
                print("Firebase login error: \(err.localizedDescription)")
            } else {
                userEmail = email
                isLoggedIn = true
            }
        }
    }

    

}

#Preview {
    LoginView()
}
