//
//  NewNoteView.swift
//  task-app
//
//  Created by Jacob Ma on 11/9/24.
//

import SwiftUI

struct NewNoteView: View {
    // ViewModel for managing the note's title and content
    @StateObject var viewModel = NewNoteViewModel()
    // Binding to control whether the new note view is presented
    @Binding var newNotePresented: Bool

    var body: some View {
        NavigationStack {
            VStack {
                // TextField for entering the note's title
                TextField("New Note", text: $viewModel.title)
                    .font(.title)
                    .bold()
                    
                // TextEditor for entering the note's content with a placeholder
                TextEditor(text: $viewModel.content)
                    .font(.body)
                    .overlay(
                        Group {
                            if viewModel.content.isEmpty {
                                VStack {
                                    HStack {
                                        // Placeholder text when content is empty
                                        Text("Tap here to continue...")
                                            .foregroundColor(Color(.systemGray3))
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        }
                    )
            }
            .padding()
            // Alert that is shown if the user tries to save without filling in the fields
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields"))
            }
            .toolbar {
                // Toolbar with the "Done" button to save the note
                ToolbarItemGroup {
                    Button("Done") {
                        // Check if the note can be saved
                        if viewModel.canSave {
                            // Save the note and dismiss the view
                            viewModel.save()
                            newNotePresented = false
                        } else {
                            // Show an alert if fields are empty
                            viewModel.showAlert = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewNoteView(newNotePresented: .constant(true))
}
