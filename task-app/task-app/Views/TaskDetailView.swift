//
//  TaskDetailView.swift
//  task-app
//
//  Created by Jacob Ma on 11/7/24.
//

import SwiftUI

struct TaskDetailView: View {
    let task: taskItem  // Property to hold the task passed to this view
    
    var body: some View {
        VStack {
            // Display the task title
            Text(task.title)
                .font(.title) // Set font size to title
            
            // Display the due date, formatted as a short date and time
            Text("Due: \(Date(timeIntervalSince1970: task.dueDate).formatted(date: .abbreviated, time: .shortened))")
            
            // Display the task's tag
            Text("Tag: \(task.tag)")
        }
        .padding() // Add padding around the VStack
    }
}

#Preview {
    // Preview of TaskDetailView with a sample task
    TaskDetailView(task: taskItem(
        id: "123",
        title: "Sample Task",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        tag: "Work",
        isDone: false,
        listId: "My List"
    ))
}
