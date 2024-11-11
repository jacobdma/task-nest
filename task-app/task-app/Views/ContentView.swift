//
//  ContentView.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//
// Main content view for the task app

import SwiftUI
import CoreImage
import UIKit

// Main view for displaying content based on user authentication status
struct ContentView: View {
    // ViewModel managing the application state and user data
    @StateObject var viewModel = ContentViewModel()
    // State variable to toggle the visibility of the menu
    @State private var showMenu = false
    // Observed router that controls the navigation between different views
    @ObservedObject var router = ContentViewModel()
    
    var body: some View {
        VStack{
            // Show account view if user is signed in, else show the login view
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                accountView
            }
            else {
                LoginView() // Show login screen if the user is not signed in
            }
        }
    }
    
    // ViewBuilder to show the account view with various tabs and buttons
    @ViewBuilder
    var accountView: some View {
        ZStack (alignment: .bottom){
            VStack {
                Spacer()
                
                // Dynamic view from the ViewModel (tasks, notes, etc.)
                viewModel.view
                
                Spacer()
                
                // Tab bar with icons for different sections of the app
                HStack {
                    TabIcon(viewModel: .tasks, router: viewModel) // Task tab
                    TabIcon(viewModel: .notes, router: viewModel) // Notes tab
                    
                    // Add button that toggles the menu
                    addButton(showMenu: $showMenu)
                        .onTapGesture {
                            withAnimation {
                                showMenu.toggle() // Toggle the menu with animation
                            }
                        }
                    
                    TabIcon(viewModel: .search, router: viewModel) // Search tab
                    TabIcon(viewModel: .settings, router: viewModel) // Settings tab
                }
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 40).fill(Color(.systemGray5)))
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            }
            
            // Popup menu that appears when the add button is tapped
            if showMenu {
                PopUpMenuView(contentViewModel: viewModel)
                    .padding(.bottom, 100)
            }
        }
        .ignoresSafeArea() // Ignore safe area insets for the entire account view
        // Sheets for creating new items or notes
        .sheet(isPresented: $viewModel.showingNewItemView) {
            NewItemView(newItemPresented: $viewModel.showingNewItemView)
        }
        .sheet(isPresented: $viewModel.showingNewNoteView) {
            NewNoteView(newNotePresented: $viewModel.showingNewNoteView)
        }
    }
}

// Add button that toggles the visibility of the menu with dynamic styling
struct addButton: View {
    @Binding var showMenu: Bool
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .symbolRenderingMode(.palette)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 56, height: 56)
            .foregroundStyle(showMenu ? Color.blue : Color.white, showMenu ? Color.white : Color.blue)
    }
}

// Tab icon for each section (Tasks, Notes, Search, Settings) with dynamic styles based on the selected tab
struct TabIcon: View {
    let viewModel: TabBarViewModel // ViewModel for the tab (tasks, notes, etc.)
    @ObservedObject var router: ContentViewModel // Router to navigate between views
    
    var body: some View {
        Button {
            router.currentItem = viewModel // Set the current tab when tapped
        } label: {
            Image(systemName: viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: router.currentItem == viewModel ? 25 : 25,
                       height: router.currentItem == viewModel ? 25 : 25)
                .frame(maxWidth: .infinity)
                .foregroundColor(router.currentItem == viewModel ? .white : .gray)
                .fontWeight(router.currentItem == viewModel ? .bold : .regular)
        }
    }
}

// Preview provider for SwiftUI previews using my userId
struct ContentView_Prefixes: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel(userId: "L4lieICJCZg6P8EAu9WN7iLQtJy2"))
    }
}
