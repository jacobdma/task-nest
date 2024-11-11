//
//  LoginModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseAuth
import Foundation

// ViewModel for handling user login
class LoginModel: ObservableObject {
    @Published var email = ""  // Published variable for email input
    @Published var password = ""  // Published variable for password input
    @Published var errorMessage = ""  // Published variable to show error messages
    
    // Initializer (currently empty, can be expanded in the future)
    init(){}
    
    // Function to handle login
    func login() {
        // First, validate the input fields before attempting login
        guard validate() else {
            return
        }
        
        // Try to log in with Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = "Login failed: \(error.localizedDescription)"
                return
            }
            // Handle successful login here (e.g., navigate to another view)
        }
    }
    
    // Function to validate email and password inputs
    private func validate() -> Bool {
        errorMessage = ""  // Reset error message
        
        // Check if email or password is empty after trimming spaces
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please fill in all fields"  // Error if any field is empty
            return false
        }
        
        // Check if email is in a valid format (contains "@" and ".")
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"  // Error if email is invalid
            return false
        }
        
        return true  // Return true if all validations pass
    }
    
    // Placeholder for register function, can be implemented later
    func register() {
        
    }
}
