//
//  User.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import Foundation

// The User struct represents a user in the app, containing basic user information.
struct User: Codable {
    let id: String          // Unique identifier for the user
    let name: String        // Name of the user
    let email: String       // Email address of the user
    let joined: TimeInterval // Timestamp for when the user joined (could be used for registration date or account creation)
}
