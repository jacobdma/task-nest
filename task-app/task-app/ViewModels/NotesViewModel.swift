//
//  NotesViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/9/24.
//

import FirebaseFirestore
import Foundation
import SwiftUI

// Enum to define different sorting options for notes
enum NotesSortOption: String, CaseIterable, Identifiable {
    case createdDate = "Created Date"  // Sort by creation date
    case lastModifiedDate = "Last Modified Date"  // Sort by last modified date
    case title = "Title"  // Sort by title
    case tag = "Tag"  // Sort by tag
    
    var id: String { rawValue }
}

class NotesViewModel: ObservableObject {
    @Published var showingNewNoteView = false  // Flag to show the view for creating a new note
    @Published var sortOption: NotesSortOption = .lastModifiedDate  // Default sorting option

    private let userId: String  // User ID to identify the notes collection in Firestore
    
    // Initializer to set userId
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete a note item
    /// - Parameter id: Item ID of the note to delete
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("notes")
            .document(id)
            .delete()  // Delete the note document from Firestore
    }
    
    // Comparator to sort notes based on the selected sorting option
    func sortComparator(lhs: Note, rhs: Note) -> Bool {
        switch sortOption {
        case .createdDate:
            return lhs.createdDate < rhs.createdDate
        case .lastModifiedDate:
            return lhs.lastModifiedDate < rhs.lastModifiedDate
        case .title:
            return lhs.title.lowercased() < rhs.title.lowercased()
        case .tag:
            return lhs.tag.lowercased() < rhs.tag.lowercased()
        }
    }

    // Function to return a color based on the note's tag
    func colorForTag(tag: String) -> Color {
        switch tag {
        case "Work":
            return .blue  // Blue for "Work" tag
        case "Personal":
            return .green  // Green for "Personal" tag
        case "Other":
            return .red  // Red for "Other" tag
        default:
            return .blue  // Default to blue if no match
        }
    }
}
