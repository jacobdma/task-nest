//
//  RegisterView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import SwiftUI

// RegisterView is for user registration
struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel() // ViewModel to handle registration logic
    
    var body: some View {
        // Main VStack containing the entire registration form
        VStack{
            // Header: Welcome text at the top of the screen
            Text("Let's Get Started!")
                .font(.title) // Title font size
                .bold() // Bold text
                .foregroundColor(.primary) // Use system primary color for text
                .padding(.bottom, 60) // Add padding at the bottom
                .padding(.top, 170) // Add padding at the top
            
            // Name TextField for user input
            TextField("Name", text: $viewModel.name)
                .padding(15) // Padding inside the text field
                .background(RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray5))) // Rounded border around the text field
                .autocorrectionDisabled(true) // Disable autocorrection for name
                .listRowBackground(Color.clear) // Remove background for row
                .listRowSeparator(.hidden) // Hide row separator
                .padding(.bottom, 10) // Add bottom padding between fields

            // Email TextField for user input
            TextField("Email Address", text: $viewModel.email)
                .padding(15) // Padding inside the text field
                .background(RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray5))) // Rounded border around the text field
                .autocapitalization(.none) // Disable auto-capitalization for email input
                .autocorrectionDisabled(true) // Disable autocorrection for email
                .listRowBackground(Color.clear) // Remove background for row
                .listRowSeparator(.hidden) // Hide row separator
                .padding(.bottom, 10) // Add bottom padding between fields

            // SecureField for password input
            SecureField("Password", text: $viewModel.password)
                .padding(15) // Padding inside the text field
                .background(RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray5))) // Rounded border around the text field
                .autocapitalization(.none) // Disable auto-capitalization for password input
                .autocorrectionDisabled(true) // Disable autocorrection for password
                .listRowBackground(Color.clear) // Remove background for row
                .listRowSeparator(.hidden) // Hide row separator

            // Custom button to create the account
            TL_Button(title: "Create Account", background: .blue) {
                viewModel.register() // Call the register function in the view model
            }
            .padding(.top, 40) // Add padding at the top of the button
            
            Spacer() // Add space at the bottom of the view to push elements up
        }
        .padding(20) // Add padding around the entire VStack
    }
}

#Preview {
    RegisterView() // Preview of RegisterView
}
