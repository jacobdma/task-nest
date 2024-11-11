//
//  ItemsViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseFirestore
import Foundation
import SwiftUI

// Enum to define available sort options for task items
enum SortOption: String, CaseIterable, Identifiable {
    case dueDate = "Due Date"  // Sort by due date
    case title = "Title"       // Sort by task title
    case tag = "Tag"           // Sort by task tag
    
    var id: String { rawValue }  // Conforms to Identifiable protocol
}

// ViewModel for managing task items in the app
class ItemsViewModel: ObservableObject {
    @Published var showingNewItemView = false   // Flag to control showing the new item view
    @Published var sortOption: SortOption = .dueDate  // Current sort option (default is by due date)
    @Published var selectedList: String = "My List"  // The currently selected task list (default is "My List")
    
    @FirestoreQuery var taskLists: [TaskList]  // A query to retrieve task lists from Firestore
    
    private let userId: String  // The user's unique ID for accessing their data
    
    // Initializer to set up the ViewModel with the user ID and fetch task lists from Firestore
    init(userId: String) {
        self.userId = userId
        
        // Initialize Firestore query for task lists under the user's account
        self._taskLists = FirestoreQuery(
            collectionPath: "users/\(userId)/tasklists"
        )
    }
    
    // Function to delete a task item by its ID
    func delete(id: String) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)    // Access the user's data
            .collection("tasks") // Reference the tasks collection
            .document(id)        // Specify the task document to delete
            .delete()            // Perform the delete operation
    }
    
    // Sort comparator to compare two task items based on the selected sort option
    func sortComparator(lhs: taskItem, rhs: taskItem) -> Bool {
        switch sortOption {
        case .dueDate:
            return lhs.dueDate < rhs.dueDate  // Compare by due date
        case .title:
            return lhs.title.lowercased() < rhs.title.lowercased()  // Compare by title (case-insensitive)
        case .tag:
            return lhs.tag.lowercased() < rhs.tag.lowercased()  // Compare by tag (case-insensitive)
        }
    }
    
    // Function to return a color based on the task's tag
    func colorForTag(tag: String) -> Color {
        switch tag {
        case "Work":
            return .blue  // Assign blue color for "Work" tag
        case "Personal":
            return .green  // Assign green color for "Personal" tag
        case "Urgent":
            return .red  // Assign red color for "Urgent" tag
        default:
            return .blue  // Default to blue color for other tags
        }
    }
}
