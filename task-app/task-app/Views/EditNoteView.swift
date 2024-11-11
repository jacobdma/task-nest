//
//  EditNoteView.swift
//  task-app
//
//  Created by Jacob Ma on 11/10/24.
//
// View for editing an existing note

import SwiftUI

struct EditNoteView: View {
    // Environment value to dismiss the view
    @Environment(\.presentationMode) var presentationMode
    // ViewModel to handle note data and logic
    @ObservedObject var viewModel: EditNoteViewModel
    // State to track if the user is editing the content
    @State private var isEditing = false

    var body: some View {
        NavigationStack {
            VStack {
                // Text field for the note title
                TextField("New Note", text: $viewModel.title)
                    .font(.title)
                    .bold()
                    
                // Text editor for the note content, with a placeholder when empty
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
            // Alert for empty fields when trying to save
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields"))
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                // "Done" button to save changes
                Button("Done") {
                    // Check if the note can be saved
                    if viewModel.canSave {
                        // Update the note and dismiss the view
                        viewModel.updateNote()
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        // Show alert if fields are empty
                        viewModel.showAlert = true
                    }
                }
            }
        }
    }
}

#Preview {
    EditNoteView(viewModel: EditNoteViewModel(note: .init(
        id: "123",
        title: "Sample Note Title",
        content: "Sample Note Content",
        createdDate: Date().timeIntervalSince1970,
        lastModifiedDate: Date().timeIntervalSince1970,
        tag: "Personal"
    )))
}
