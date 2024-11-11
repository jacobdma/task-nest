//
//  LoginView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//
//  View for user login

import SwiftUI

struct LoginView: View {
    // ViewModel for handling login logic
    @StateObject var viewModel = LoginModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Welcome message
                Text("Welcome Back!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.bottom, 30)
                    .padding(.top, 200)
                
                // Display error message if login fails
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .foregroundColor(.red)
                }
                
                // Email text field
                // Binds email input to the view model's 'email' property
                TextField("Email Address", text: $viewModel.email)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray5)))
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .padding(.bottom, 10)
                
                // Password secure field
                // Binds password input to the view model's 'password' property
                SecureField("Password", text: $viewModel.password)
                    .padding(15)
                    .background(RoundedRectangle(cornerRadius: 25).stroke(Color(.systemGray5)))
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                
                // Login button
                TL_Button(title: "Log In", background: .blue) { viewModel.login() }
                    .padding(.top, 40)
                    .padding(.bottom, 180)
                
                // Option for creating an account
                Text("Don't have an account?")
                NavigationLink("Create an Account", destination: RegisterView())
                
                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    LoginView()
}
