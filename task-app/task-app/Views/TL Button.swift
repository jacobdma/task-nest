//
//  TL Button.swift
//  task-app
//
//  Created by Jacob Ma on 11/5/24.
//

import SwiftUI

// Custom button view with a title, background color, and an action closure
struct TL_Button: View {
    let title: String            // Title text for the button
    let background: Color        // Background color of the button
    let action: () -> Void       // Action closure to execute when the button is tapped
    
    var body: some View {
        Button {
            action()  // Execute the passed action when the button is pressed
        } label: {
            ZStack {
                // Rounded rectangle for the button's background
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(background)
                
                // Title text displayed in the button, white and bold
                Text(title)
                    .foregroundColor(.white)
                    .bold()
            }
        }
        .frame(width: 200, height: 50) // Fixed size for the button
    }
}

// Preview for the TL_Button with a sample action
struct TL_Button_Previews {
    static var previews: some View {
        TL_Button(title: "Value",
                  background: .blue) {
            // Sample action (can be replaced with real action)
        }
    }
}
