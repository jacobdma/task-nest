//
//  TaskList.swift
//  task-app
//
//  Created by Jacob Ma on 11/11/24.
//

import Foundation

// The TaskList struct represents a collection of tasks, each list having an ID and a title.
struct TaskList: Identifiable, Codable {
    let id: String    // Unique identifier for the task list
    let title: String // The title of the task list (e.g., "Work Tasks", "Personal Tasks")

    // Converts the TaskList to a dictionary format to store it in a database (e.g., Firestore).
    func asDictionary() -> [String: Any] {
        return [
            "id": id,       // List ID
            "title": title  // List Title
        ]
    }
}
