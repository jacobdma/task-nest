//
//  NewItemView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//
//  View for adding a new task item

import SwiftUI

struct NewItemView: View {
    // ViewModel for handling new item logic
    @StateObject var viewModel = NewItemViewModel()
    
    // Binding to control the presentation of the view
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Form {
                // Text field for task title input
                // Binds the input to the view model's 'title' property
                TextField("Title", text: $viewModel.title)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color(.systemGray6)))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                // Date picker for selecting the task's due date
                // Binds the selected date to the view model's 'dueDate' property
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)  // Prevents scrollable content from having a background
            
            // Alert shown if the user attempts to save with missing fields
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error"), message: Text("Please fill in all fields"))
            }
            
            Spacer()
            
            // Button to add the task
            // Triggers validation before saving the task
            TL_Button(title: "Add Task", background: .blue) {
                // Check if all fields are valid and can be saved
                if viewModel.canSave {
                    // Saves the new task item if valid
                    viewModel.save()
                    // Closes the view after saving
                    newItemPresented = false
                }
                else {
                    // Shows an alert if the fields are invalid
                    viewModel.showAlert = true
                }
            }
        }
    }
}

#Preview {
    NewItemView(newItemPresented: .constant(true))
}
