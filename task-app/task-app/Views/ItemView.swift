//
//  ItemView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//
//  View for displaying a task item

import SwiftUI

struct ItemView: View {
    // ViewModel for handling task logic
    @StateObject var viewModel = ItemViewModel()
    
    // Task item and tag color passed in
    let item: taskItem
    let tagColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    // Circle indicating the task's tag color
                    Image(systemName: "circle.fill")
                        .foregroundColor(tagColor)
                        .font(.system(size: 10))
                    
                    Spacer()
                        .frame(width: 10)
                    
                    // Task title with strikethrough if task is completed
                    Text(item.title)
                        .strikethrough(item.isDone)
                        .font(.headline)
                }
                
                Spacer()
                    .frame(height: 5)
                
                // Due date for the task, formatted to show abbreviated date and shortened time
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .foregroundColor(Color(.secondaryLabel))
            }
            
            Spacer()
            
            // Button to toggle task completion status
            Button {
                viewModel.toggleIsDone(item: item)
            } label: {
                // Checkmark icon when task is done, circle icon when not done
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
                    .font(.system(size: 16))
            }
        }
    }
}

#Preview {
    ItemView(item: .init(
        id: "123",
        title: "Dummy Task",
        dueDate: Date().timeIntervalSince1970,
        createdDate: Date().timeIntervalSince1970,
        tag: "Personal",
        isDone: false,
        listId: "My List"
    ), tagColor: .green)
}
