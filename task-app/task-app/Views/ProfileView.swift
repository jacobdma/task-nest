//
//  ProfileView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import FirebaseFirestore
import SwiftUI

// ProfileView for displaying user profile information
struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel() // ViewModel for managing profile data
    
    // Initializer
    init() {
        
    }
    
    var body: some View {
        NavigationView{
            VStack {
                // If user data is available, display profile view; otherwise, show loading text
                if let user = viewModel.user {
                    profile(user: user) // Call profile function to display user data
                } else {
                    Text("Loading profile...") // Show loading text while fetching user data
                }
            }
            .navigationTitle("Profile") // Set navigation title to "Profile"
        }
        .onAppear {
            // Fetch user data when the view appears
            viewModel.fetchUser()
        }
    }
    
    // Profile display function using @ViewBuilder for conditional views
    @ViewBuilder
    func profile(user: User) -> some View {
        // Welcome message with user's name
        Text("Hi,  " + user.name + "!")
            .font(.title)
            .padding()
        
        // Avatar: Person icon with circular frame
        Image(systemName: "person.crop.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.blue) // Avatar color set to blue
            .frame(width: 125, height: 125) // Set avatar size
        
        // User information: Email display
        VStack(alignment: .leading) {
            HStack {
                Text("Email")
                    .bold() // Bold text for "Email"
                Text(user.email) // Display user's email
            }
        }
        
        // Log out button to trigger the logOut function in the view model
        Button("Log out") {
            viewModel.logOut() // Log out the user
        }
        .tint(.red) // Set button color to red
        .padding() // Add padding around the button
    }
}

#Preview {
    ProfileView() // Preview for ProfileView
}
