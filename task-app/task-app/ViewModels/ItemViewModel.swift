//
//  ItemViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

// ViewModel for managing task item data
class ItemViewModel: ObservableObject {

    // Initializer (currently empty but can be expanded in the future)
    init() {}
    
    // Function to toggle the "isDone" status of a task item
    // - Parameter item: The task item whose "isDone" status is to be toggled
    func toggleIsDone(item: taskItem) {
        var newItem = item  // Create a copy of the task item
        
        // Toggle the "isDone" status
        newItem.toggleDone(!item.isDone)
        
        // Ensure the user is authenticated by retrieving their UID
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()  // Initialize Firestore
        
        // Update the task in the Firestore database with the new "isDone" status
        db.collection("users")  // Access the user's data in Firestore
            .document(uid)  // Use the user's UID to target the correct document
            .collection("tasks")  // Work within the "tasks" collection
            .document(newItem.id)  // Reference the specific task document by its ID
            .setData(newItem.asDictionary())  // Update the task with the new data (status)
    }
}
