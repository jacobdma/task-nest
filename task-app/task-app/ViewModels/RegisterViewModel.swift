//
//  RegisterViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseFirestore
import FirebaseAuth
import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""  // User's name input
    @Published var email: String = "" // User's email input
    @Published var password: String = "" // User's password input
    
    init() {}

    /// Register a new user in Firebase Authentication
    func register() {
        // Validate user inputs before attempting registration
        guard validate() else {
            return
        }
        
        // Create a new user in Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            // Handle errors or missing user ID
            guard let userID = result?.user.uid else {
                return
            }
            
            // If successful, insert the new user record in Firestore
            self?.insertUserRecord(id: userID)
        }
    }
    
    /// Insert user data into Firestore
    private func insertUserRecord(id: String) {
        // Create a new User object
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        // Save the new user data to Firestore under the "users" collection
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    /// Validate the user's input data
    private func validate() -> Bool {
        // Check that all fields are filled and meet requirements
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        // Check that the email is valid
        guard email.contains("@") && email.contains(".") else {
            return false
        }
        
        // Check that the password is at least 8 characters
        guard password.count >= 8 else {
            return false
        }
        
        return true
    }
}
