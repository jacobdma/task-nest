//
//  ItemsView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//
//  Tasks View

import FirebaseFirestore
import SwiftUI

// Main view for displaying items (tasks) in a specific list
struct ItemsView: View {
    // ViewModel managing the list of items and sorting/filtering logic
    @StateObject var viewModel: ItemsViewModel
    // Firestore query to fetch tasks for a specific user
    @FirestoreQuery var items: [taskItem]
    // Default list name
    let list: String = "My List"
    
    // Initialize with a specific user ID
    init(userId: String) {
        // Initialize Firestore query to fetch tasks from the user's collection
        self._items = FirestoreQuery(
            collectionPath: "users/\(userId)/tasks"
        )
        // Initialize the view model with the provided user ID
        self._viewModel = StateObject(
            wrappedValue: ItemsViewModel(userId: userId)
        )
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Horizontal stack for displaying list selection buttons
                HStack {
                    // Button to select a default list
                    listItem(listOption: "My List", viewModel: viewModel)
                    
                    // Display buttons for each custom list in viewModel.taskLists
                    ForEach(viewModel.taskLists) { list in
                        listItem(listOption: list.title, viewModel: viewModel)
                    }
                    
                    // Button to add a new list, with placeholder functionality for now
                    Button(action: {
                        // Placeholder for showing a text box to create a new list
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
                
                // Horizontal stack for sorting options
                HStack {
                    Spacer()
                    
                    // Sort Picker allowing the user to sort items by selected criteria
                    Picker("Sort by", selection: $viewModel.sortOption) {
                        ForEach(SortOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal, 20)
                }
                
                // Displaying the filtered and sorted list of items
                List(filteredAndSortedItems) { item in
                    // Display each item with conditional styling based on its tag
                    ItemView(item: item, tagColor: viewModel.colorForTag(tag: item.tag))
                        .swipeActions {
                            // Delete action for each item
                            Button("Delete") {
                                viewModel.delete(id: item.id)
                            }
                            .tint(.red)
                        }
                }
            }
            // Overlay to display a "No Tasks" message when there are no items in the selected list
            .overlay(
                Group {
                    if filteredAndSortedItems.isEmpty {
                        VStack {
                            Spacer()
                                .frame(height: 130)
                            
                            Image(systemName: "list.bullet")
                                .foregroundColor(.blue)
                                .font(.largeTitle)
                                .padding()
                            
                            Text("No Tasks")
                                .font(.title2)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                    }
                }
            )
            .navigationTitle("Tasks")
        }
    }
    
    // Computed property to filter and sort items based on the selected list and sort option
    private var filteredAndSortedItems: [taskItem] {
        items
            .filter { $0.listId == viewModel.selectedList } // Filters by the selected list
            .sorted(by: viewModel.sortComparator) // Sorts according to the selected sort option
    }
}

// View for each list selection button
struct listItem: View {
    var listOption: String // List title to display
    @ObservedObject var viewModel: ItemsViewModel // Reference to the main view model
    
    var body: some View {
        // Button to select a list, updating the view model with the selected list
        Button(listOption) {
            viewModel.selectedList = listOption
        }
    }
}

// Preview provider for SwiftUI previews using my userId
#Preview {
    ItemsView(userId: "L4lieICJCZg6P8EAu9WN7iLQtJy2")
}
