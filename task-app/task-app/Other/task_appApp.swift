//
//  task_appApp.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import SwiftUI
import FirebaseCore

@main
struct task_appApp: App {
    init (){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
