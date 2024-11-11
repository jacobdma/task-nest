//
//  Task.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import Foundation
import SwiftUI

// The taskItem struct represents a task within the app, including its properties and methods.
struct taskItem: Identifiable, Codable, Hashable {
    let id: String               // Unique identifier for the task
    let title: String            // The title or name of the task
    let dueDate: TimeInterval    // The due date for the task (timestamp)
    let createdDate: TimeInterval // The date when the task was created (timestamp)
    let tag: String              // A tag (e.g., Work, Personal) associated with the task
    var isDone: Bool             // Status indicating if the task is completed
    var listId: String = "My List" // The ID of the list this task belongs to (default is "My List")

    // Converts the taskItem to a dictionary format to store it in a database (e.g., Firestore).
    func asDictionary() -> [String: Any] {
        return [
            "id": id,                               // Task ID
            "title": title,                         // Task Title
            "dueDate": dueDate,                     // Due Date
            "createdDate": createdDate,             // Creation Date
            "tag": tag,                             // Associated Tag
            "isDone": isDone,                       // Completion Status
            "listId": listId                        // The List ID this task belongs to
        ]
    }
    
    // Method to toggle the task completion status.
    mutating func toggleDone(_ isDone: Bool) {
        self.isDone = isDone
    }
}
