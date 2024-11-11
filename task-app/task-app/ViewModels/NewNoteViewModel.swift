//
//  NewNoteViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/9/24.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI

// ViewModel for handling the creation of new notes
class NewNoteViewModel: ObservableObject {
    @Published var title = ""  // Title of the new note
    @Published var content = ""  // Content of the new note
    @Published var lastModifiedDate: TimeInterval = Date().timeIntervalSince1970  // Last modified date
    @Published var showAlert = false  // Flag to show an alert (for errors or success)
    @Published var tag: String? = nil  // Tag for the new note
    
    // Predefined tag options for notes
    let tagOptions = [
        "Work", "Personal", "Other"
    ]
    
    // Initializer (empty, but can be extended in the future)
    init() {}
    
    // Function to save the new note to Firestore
    func save() {
        // Get the current user id from Firebase Authentication
        guard let uId = Auth.auth().currentUser?.uid else {
            return  // If no user is logged in, exit the function
        }
        
        // Create a new note model with a unique id
        let newId = UUID().uuidString
        let newNote = Note(
            id: newId,  // Unique note ID
            title: title,  // Note title
            content: content,  // Note content
            createdDate: Date().timeIntervalSince1970,  // Created date as timestamp
            lastModifiedDate: lastModifiedDate,  // Last modified date as timestamp
            tag: tag ?? "No Tag"  // Tag for the note (default "No Tag" if nil)
        )
        
        // Save the new note to Firestore under the current user's notes collection
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("notes")
            .document(newId)
            .setData(newNote.asDictionary())  // Save note data as dictionary
    }
    
    // Computed property to check if the note can be saved
    var canSave: Bool {
        // Check if the title is not empty after trimming whitespace and newlines
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        return true  // Note can be saved if the title is not empty
    }
}
