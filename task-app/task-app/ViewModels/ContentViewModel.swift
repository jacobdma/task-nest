//
//  ContentViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseAuth
import Foundation
import SwiftUI

// ViewModel that manages the content and current user state for the main view
class ContentViewModel: ObservableObject {
    @Published var currentUserId: String = ""        // Current logged-in user ID
    @Published var currentItem: TabBarViewModel = .tasks // Current selected tab
    @Published var showingNewItemView = false        // Flag for showing new item view
    @Published var showingNewNoteView = false        // Flag for showing new note view
    
    // View corresponding to the selected tab
    var view: some View {
        currentItem.view(currentUserId: currentUserId)
    }
    
    // Firebase authentication state listener handle
    private var handler: AuthStateDidChangeListenerHandle?
    
    // Initializer with optional userId (can be passed or fetched from Firebase)
    init(userId: String = "") {
        if userId.isEmpty {
            // Add Firebase auth state change listener to update the userId
            self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
                DispatchQueue.main.async {
                    self?.currentUserId = user?.uid ?? ""  // Update userId
                }
            }
        } else {
            self.currentUserId = userId  // Set userId directly if provided
        }
    }
    
    // Property to check if the user is signed in
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil  // Check if there's an authenticated user
    }
}

// Enum representing the different tabs in the tab bar
enum TabBarViewModel: Int, CaseIterable {
    case settings
    case search
    case tasks
    case notes
    
    // Image name for each tab, based on the tab type
    var imageName: String {
        switch self {
            case .tasks: return "list.bullet"
            case .notes: return "note.text"
            case .search: return "magnifyingglass"
            case .settings: return "gearshape.fill"
        }
    }
    
    // Returns the corresponding view for each tab, passing the currentUserId
    func view(currentUserId: String) -> AnyView {
        switch self {
        case .tasks:
            return AnyView(ItemsView(userId: currentUserId)) // Tasks view
        case .notes:
            return AnyView(NotesView(userId: currentUserId)) // Notes view
        case .search:
            return AnyView(SearchView(userId: currentUserId)) // Search view
        case .settings:
            return AnyView(ProfileView()) // Profile view (settings)
        }
    }
}
