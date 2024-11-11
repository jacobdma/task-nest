//
//  SearchView.swift
//  task-app
//
//  Created by Jacob Ma on 11/10/24.
//

import SwiftUI
import FirebaseFirestore

// ItemCategory and NoteCategory structs to group taskItems and Notes for display
struct SearchView: View {
    struct ItemCategory: Identifiable {
        let name: String
        let items: [taskItem] // List of task items
        let id = UUID() // Unique identifier for category
    }

    struct NoteCategory: Identifiable {
        let name: String
        let notes: [Note] // List of notes
        let id = UUID() // Unique identifier for category
    }

    @StateObject var viewModel: SearchViewModel // ViewModel to manage search query and filter logic
    @ObservedObject private var itemsViewModel: ItemsViewModel // ViewModel to manage task items
    @ObservedObject private var notesViewModel: NotesViewModel // ViewModel to manage notes
    @FirestoreQuery var items: [taskItem] // Firestore query to fetch task items
    @FirestoreQuery var notes: [Note] // Firestore query to fetch notes

    // Initializing viewModel and FirestoreQuery properties with userId
    init(userId: String) {
        self._viewModel = StateObject(wrappedValue: SearchViewModel()) // Initialize SearchViewModel
        self.itemsViewModel = ItemsViewModel(userId: userId) // Initialize ItemsViewModel
        self.notesViewModel = NotesViewModel(userId: userId) // Initialize NotesViewModel

        // Set Firestore query paths for tasks and notes
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/tasks" // Firestore path for tasks
        )

        self._notes = FirestoreQuery(
            collectionPath: "users/\(userId)/notes" // Firestore path for notes
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                // Search text field for input
                TextField("Search", text: $viewModel.searchQuery)
                    .padding()
                    .background(Color(.systemGray6)) // Background color for the text field
                    .cornerRadius(50) // Rounded corners for the text field
                    .padding()

                List {
                    // Section for Tasks
                    if !viewModel.filteredItems.isEmpty { // Only show if there are filtered tasks
                        Section(header: Text("Tasks")) {
                            // Display each task item
                            List(viewModel.filteredItems) { item in
                                ItemView(item: item, tagColor: itemsViewModel.colorForTag(tag: item.tag))
                                    .swipeActions {
                                        // Swipe action to delete the item
                                        Button("Delete") {
                                            itemsViewModel.delete(id: item.id) // Call delete method from viewModel
                                        }
                                        .tint(.red) // Set delete button color
                                    }
                            }
                        }
                    }

                    // Section for Notes
                    if !viewModel.filteredNotes.isEmpty { // Only show if there are filtered notes
                        Section(header: Text("Notes")) {
                            // Display each note
                            List(viewModel.filteredNotes) { note in
                                NoteView(note: note, tagColor: notesViewModel.colorForTag(tag: note.tag))
                                    .swipeActions {
                                        // Swipe action to delete the note
                                        Button("Delete") {
                                            notesViewModel.delete(id: note.id) // Call delete method from viewModel
                                        }
                                        .tint(.red) // Set delete button color
                                    }
                            }
                        }
                    }
                }
                .overlay(
                    Group {
                        if viewModel.filteredItems.isEmpty && viewModel.filteredNotes.isEmpty { // Show "No Results" if nothing is found
                            VStack {
                                Spacer()
                                    .frame(height: 100) // Add some space at the top

                                Image(systemName: "magnifyingglass") // Magnifying glass icon
                                    .foregroundColor(.gray) // Icon color
                                    .font(.largeTitle) // Icon size
                                    .padding()

                                Text("No Results") // No results text
                                    .font(.title2)
                                    .foregroundColor(.secondary) // Text color
                                    .frame(maxWidth: .infinity)

                                Spacer()
                            }
                        }
                    }
                )
                Spacer() // Add space at the bottom of the view
            }
            .navigationTitle("Search") // Set the navigation title
        }
        // Call the filter methods whenever Firestore data or search query changes
        .onChange(of: items, initial: true) {
            viewModel.filterItems(items: items) // Filter tasks when items change
        }
        .onChange(of: notes, initial: true) {
            viewModel.filterNotes(notes: notes) // Filter notes when notes change
        }
        .onChange(of: viewModel.searchQuery) { newQuery in
            viewModel.filterItems(items: items) // Filter tasks when search query changes
            viewModel.filterNotes(notes: notes) // Filter notes when search query changes
        }
    }
}

#Preview {
    SearchView(userId: "L4lieICJCZg6P8EAu9WN7iLQtJy2") // Preview with a sample userId
}
