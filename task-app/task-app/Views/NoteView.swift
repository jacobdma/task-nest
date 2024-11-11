//
//  NoteView.swift
//  task-app
//
//  Created by Jacob Ma on 11/9/24.
//

import SwiftUI

struct NoteView: View {
    // Properties for the note data and the tag color to be used
    let note: Note
    let tagColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            // Display the note title with a headline font
            Text(note.title)
                .font(.headline)
            
            Spacer()
                .frame(height: 5)
            
            // Display the note content, with a fallback message if content is empty
            Text(!note.content.isEmpty ? note.content : "No Additional Text")
                .lineLimit(2) // Limit content to two lines
                .frame(maxWidth: .infinity, alignment: .leading) // Align to the left and allow it to expand
                .foregroundColor(Color(.label)) // Default text color
            
            Spacer()
                .frame(height: 5)
            
            // Display the last modified date, formatted for readability
            Text("\(Date(timeIntervalSince1970: note.lastModifiedDate).formatted(date: .abbreviated, time: .shortened))")
                .foregroundColor(Color(.secondaryLabel)) // Lighter color for the date
        }
        .frame(maxWidth: .infinity) // Make the view expand to the maximum width available
    }
}

#Preview {
    // Preview of the NoteView with sample note data and a tag color
    NoteView(note: .init(
        id: "123",
        title: "Hello, World!",
        content: "This is a sample note.",
        createdDate: Date().timeIntervalSince1970,
        lastModifiedDate: Date().timeIntervalSince1970,
        tag: "Personal"
    ), tagColor: .green)
}
