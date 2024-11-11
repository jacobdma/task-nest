//
//  EditNoteViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/10/24.
//

import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseFirestore

// ViewModel for editing a note
class EditNoteViewModel: ObservableObject {
    @Published var title: String        // The note's title
    @Published var content: String      // The note's content
    @Published var showAlert = false    // Flag to show alert (e.g., for empty content)
    private var note: Note              // The original note being edited
    
    // Initializer, setting up the view model with the note data
    init(note: Note) {
        self.note = note
        self.title = note.title           // Initialize title with existing note title
        self.content = note.content       // Initialize content with existing note content
    }
    
    // Computed property to check if the note content is non-empty and ready to be saved
    var canSave: Bool {
        !content.isEmpty  // Can only save if content is not empty
    }
    
    // Function to update the note in Firestore
    func updateNote() {
        guard let uId = Auth.auth().currentUser?.uid else {
            return  // If user is not authenticated, do not proceed
        }
        
        // Create an updated note object with new title/content and current timestamp for modification
        let updatedNote = Note(
            id: note.id,  // Keep the existing note ID
            title: title,
            content: content,
            createdDate: note.createdDate,  // Keep original creation date
            lastModifiedDate: Date().timeIntervalSince1970,  // Set current time as last modified date
            tag: note.tag  // Keep existing tag
        )
        
        // Access Firestore and update the note data
        let db = Firestore.firestore()
        db.collection("users")  // Reference to the user's notes collection
            .document(uId)      // Use the authenticated user's ID
            .collection("notes") // Access the notes collection
            .document(updatedNote.id)  // Use the same note ID for updating
            .setData(updatedNote.asDictionary())  // Save the updated note as a dictionary
    }
}
