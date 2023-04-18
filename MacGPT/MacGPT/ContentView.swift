//
//  ContentView.swift
//  MacGPT
//
//  Created by Daniel Santiago on 4/14/23.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    @State private var conversation: [String] = []
    @State private var apiKey: String = ""
    @State private var isShowingSettings: Bool = false

    private let pythonBridge = PythonBridge()

    init() {
        if let savedApiKey = UserDefaults.standard.string(forKey: "apiKey") {
            apiKey = savedApiKey
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(conversation, id: \.self) { text in
                            Text(text)
                        }
                    }
                }

                Spacer()

                Button("Settings") {
                    isShowingSettings = true
                }
                .sheet(isPresented: $isShowingSettings) {
                    SettingsView(apiKey: $apiKey, isPresented: $isShowingSettings)
                }
                .padding(.bottom)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("MacGPT")

            HStack {
                TextField("Type your message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)
                    .frame(width: 900, height: 50)

                Button(action: sendMessage) {
                    Text("Send")
                        .padding(.horizontal)
                }
            }
        }
    }

    private func sendMessage() {
        conversation.append("You: \(message)")
        let response = pythonBridge.answerQuestion(apiKey: apiKey, vectorIndexFile: "~/Library/Application Support/MacGPT/TextFiles", question: message)
        conversation.append("Chatbot: \(response)")
        message = ""
    }
}




