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

    var body: some View {
        NavigationView {
            VStack {
                List(conversation, id: \.self) { text in
                    Text(text)
                }

                Button("Settings") {
                    isShowingSettings = true
                }
                .sheet(isPresented: $isShowingSettings) {
                    SettingsView(apiKey: $apiKey)
                }

                HStack {
                    TextField("Type your message...", text: $message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)

                    Button(action: sendMessage) {
                        Text("Send")
                            .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle("MacGPT")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func sendMessage() {
        conversation.append("You: \(message)")
        let response = pythonBridge.answerQuestion(apiKey: apiKey, vectorIndexFile: "~/Library/Application Support/MacGPT/TextFiles", question: message)
        conversation.append("Chatbot: \(response)")
        message = ""
    }


}
