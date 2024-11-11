//
//  NewItemViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

// ViewModel for handling new task creation
class NewItemViewModel: ObservableObject {
    @Published var title = ""  // Title of the new task
    @Published var dueDate = Date()  // Due date of the new task
    @Published var showAlert = false  // Flag to show an alert (for errors or success)
    @Published var tag: String? = nil  // Tag for the new task
    
    // Predefined tag options for tasks
    let tagOptions = [
        "Work", "Personal", "Urgent"
    ]
    
    // Initializer (empty, but can be extended in the future)
    init() {}
    
    // Function to save the new task to Firestore
    func save() {
        // Get the current user id from Firebase Authentication
        guard let uId = Auth.auth().currentUser?.uid else {
            return  // If no user is logged in, exit the function
        }
        
        // Create a new task item with a unique id
        let newId = UUID().uuidString
        let newItem = taskItem(
            id: newId,  // Unique task ID
            title: title,  // Task title
            dueDate: dueDate.timeIntervalSince1970,  // Due date converted to timestamp
            createdDate: Date().timeIntervalSince1970,  // Created date as timestamp
            tag: tag ?? "No Tag",  // Tag for the task (default "No Tag" if nil)
            isDone: false  // Task is initially not done
        )
        
        // Save the new task to Firestore under the current user's tasks collection
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("tasks")
            .document(newId)
            .setData(newItem.asDictionary())  // Save task data as dictionary
    }
    
    // Computed property to check if the task can be saved
    var canSave: Bool {
        // Check if the title is not empty after trimming whitespace and newlines
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        // Check if the due date is in the future (at least one day ahead)
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true  // Task can be saved if both conditions pass
    }
}
