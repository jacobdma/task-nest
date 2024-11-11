//
//  PopUpMenuView.swift
//  task-app
//
//  Created by Jacob Ma on 11/9/24.
//

import SwiftUI

// Enum defining the menu items and their actions
enum MenuViewModel: Int, CaseIterable {
    case createTask
    case createNote
    
    // Return corresponding system image name for each menu item
    var imageName: String {
        switch self {
            case .createTask: return "list.bullet"
            case .createNote: return "note.text"
        }
    }
    
    // Return description text for each menu item
    var description: String {
        switch self {
            case .createTask: return "Create Task"
            case .createNote: return "Create Note"
        }
    }
    
    // Return action closure based on the selected menu item
    func action(contentViewModel: ContentViewModel) -> () -> Void {
        switch self {
        case .createTask:
            return {
                // Show the new item view for creating a task
                contentViewModel.showingNewItemView = true
                print("Creating Task, showingNewItemView: \(contentViewModel.showingNewItemView)")
            }
        case .createNote:
            return {
                // Show the new note view for creating a note
                contentViewModel.showingNewNoteView = true
                print("Creating Note, showingNewNoteView: \(contentViewModel.showingNewNoteView)")
            }
        }
    }
}

// PopUpMenuView for displaying the menu options
struct PopUpMenuView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        // Horizontal stack to display menu items with spacing
        HStack (spacing: 24) {
            Spacer() // Spacer to center the menu items
            // For each menu item, display a corresponding MenuItem
            ForEach(MenuViewModel.allCases, id: \.self) { menuItem in
                MenuItem(viewModel: menuItem, contentViewModel: contentViewModel)
            }
            Spacer() // Spacer to center the menu items
        }
        .transition(.scale) // Apply scale transition for menu display
    }
}

// MenuItem view representing each item in the popup menu
struct MenuItem: View {
    let viewModel: MenuViewModel
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        VStack (alignment: .center, spacing: 12) {
            // Button to trigger the action for the menu item
            Button(action: {
                // Execute the closure returned by the action function
                viewModel.action(contentViewModel: contentViewModel)()
            }) {
                ZStack {
                    // Circle background for the menu item
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                    
                    // Image for the menu item icon
                    Image(systemName: viewModel.imageName)
                        .symbolRenderingMode(.palette)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white) // White color for the icon
                        .padding(12) // Padding around the icon
                }
            }
            
            // Description text for the menu item
            Text(viewModel.description)
                .foregroundColor(.white) // White color for the text
                .font(.footnote) // Font size for the description
        }
        .padding() // Padding around the entire MenuItem
    }
}

#Preview {
    PopUpMenuView(contentViewModel: ContentViewModel())
}
