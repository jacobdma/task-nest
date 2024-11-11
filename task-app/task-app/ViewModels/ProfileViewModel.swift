//
//  ProfileViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewModel: ObservableObject {
    // Initializer for the view model
    init() {}
    
    @Published var user: User? = nil  // Published property to store the current user's data
    
    /// Fetch user data from Firestore
    func fetchUser() {
        // Get the current authenticated user's ID
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { [weak self] snapshot, error in
            // Handle error or missing data
            guard let data = snapshot?.data(), error == nil else { return }
        
            // Update the user property on the main thread with the fetched data
            DispatchQueue.main.async {
                self?.user = User(
                    id: data["id"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    joined: data["joined"] as? TimeInterval ?? 0
                )
            }
        }
    }
    
    /// Log out the current user
    func logOut() {
        do {
            try Auth.auth().signOut()  // Sign out from Firebase Authentication
        } catch {
            print(error)  // Print any errors encountered during logout
        }
    }
}
