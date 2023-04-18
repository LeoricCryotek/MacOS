//
//  SetttingsView.swift
//  MacGPT
//
//  Created by Daniel Santiago on 4/14/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var apiKey: String
    @Binding var isPresented: Bool
    @State private var savedMessage: String = ""

    var body: some View {
        VStack {
            Text("API Key")
                .font(.headline)
            TextField("Enter API Key", text: $apiKey)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, height: 30) // Adjust the width as needed

            Text(savedMessage)
                .foregroundColor(.green)

            HStack {
                Button("Save") {
                    UserDefaults.standard.set(apiKey, forKey: "apiKey")
                    savedMessage = "Saved"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        isPresented = false
                    }
                }
                .padding(.horizontal)

                Button("Exit") {
                    isPresented = false
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .padding()
    }
}

