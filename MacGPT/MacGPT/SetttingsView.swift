//
//  SetttingsView.swift
//  MacGPT
//
//  Created by Daniel Santiago on 4/14/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var apiKey: String
    @State private var tempApiKey: String = ""

    var body: some View {
        VStack {
            TextField("Enter API Key", text: $tempApiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: saveApiKey) {
                Text("Save API Key")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.top)
        }
        .padding()
    }
    
    private func saveApiKey() {
        apiKey = tempApiKey
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(apiKey: .constant(""))
    }
}
