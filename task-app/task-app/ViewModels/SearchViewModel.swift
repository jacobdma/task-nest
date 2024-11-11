//
//  SearchViewModel.swift
//  task-app
//
//  Created by Jacob Ma on 11/10/24.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var searchQuery: String = ""  // The current search query entered by the user
    
    var filteredItems: [taskItem] = [] // Holds the filtered task items based on search query
    var filteredNotes: [Note] = [] // Holds the filtered notes based on search query
    
    /// Filters the task items based on the search query
    /// - Parameter items: The array of task items to be filtered
    func filterItems(items: [taskItem]) {
        if searchQuery.isEmpty {
            filteredItems = items // If search query is empty, show all items
        } else {
            // Filter items where the title contains the search query (case insensitive)
            filteredItems = items.filter { $0.title.lowercased().contains(searchQuery.lowercased()) }
        }
    }
    
    /// Filters the notes based on the search query
    /// - Parameter notes: The array of notes to be filtered
    func filterNotes(notes: [Note]) {
        if searchQuery.isEmpty {
            filteredNotes = notes // If search query is empty, show all notes
        } else {
            // Filter notes where the title or content contains the search query (case insensitive)
            filteredNotes = notes.filter {
                $0.title.lowercased().contains(searchQuery.lowercased()) ||
                $0.content.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
}
