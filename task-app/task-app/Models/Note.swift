//
//  Note.swift
//  task-app
//
//  Created by Jacob Ma on 11/8/24.
//

import Foundation
import SwiftUI

// The Note struct represents a single note object with essential properties.
struct Note: Identifiable, Codable, Hashable {
    var id: String               // Unique identifier for the note
    var title: String            // The title of the note
    var content: String          // The main content or body of the note
    var createdDate: TimeInterval // Timestamp of when the note was created
    var lastModifiedDate: TimeInterval // Timestamp of when the note was last modified
    let tag: String              // A tag associated with the note (e.g., Work, Personal, etc.)

    // Method to convert the Note into a dictionary format
    // Useful for saving the note to Firestore or another database.
    func asDictionary() -> [String: Any] {
        return [
            "id": id,                              // Note ID
            "title": title,                        // Note Title
            "content": content,                    // Note Content
            "createdDate": createdDate,            // Creation Timestamp
            "lastModifiedDate": lastModifiedDate,  // Last Modified Timestamp
            "tag": tag                             // Associated Tag
        ]
    }
}
