//
//  NotesView.swift
//  task-app
//
//  Created by Jacob Ma on 11/9/24.
//

import FirebaseFirestore
import SwiftUI

struct NotesView: View {
    // ViewModel managing the notes data and logic
    @StateObject var viewModel: NotesViewModel
    // Firestore query to fetch notes for a specific user
    @FirestoreQuery var notes: [Note]
        
    // Initialize with a specific user ID
    init(userId: String) {
        // Initialize Firestore query to fetch notes from the user's collection
        self._notes = FirestoreQuery(
            collectionPath: "users/\(userId)/notes"
        )
        // Initialize the view model with the provided user ID
        self._viewModel = StateObject(
            wrappedValue: NotesViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                
                    // Picker for sorting options (e.g., by date, title, etc.)
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        ForEach(NotesSortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal, 20)
                }
                
                // Display list of notes, sorted by the selected option
                List(notes.sorted(by: viewModel.sortComparator)) { note in
                    // Custom view to display each note, with associated tag color
                    NoteView(note: note, tagColor: viewModel.colorForTag(tag: note.tag))
                        .swipeActions {
                            // Swipe action for deleting a note
                            Button("Delete") {
                                viewModel.delete(id: note.id)
                            }
                            .tint(.red)
                        }
                }
            }
            // Overlay to display a message when no notes are available
            .overlay(
                Group {
                    if notes.isEmpty {
                        VStack {
                            Image(systemName: "note.text")
                                .foregroundColor(.blue)
                                .font(.largeTitle)
                                .padding()
                            
                            Text("No Notes")
                                .font(.title2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            )
            .navigationTitle("Notes")
        }
    }
}

#Preview {
    NotesView(userId: "L4lieICJCZg6P8EAu9WN7iLQtJy2")
}
