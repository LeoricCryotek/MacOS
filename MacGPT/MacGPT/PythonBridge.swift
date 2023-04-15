//
//  PythonBridge.swift
//  MacGPT
//
//  Created by Daniel Santiago on 4/14/23.
//

import Foundation
import PythonKit

class PythonBridge {
    
    private var conversation: [String] = []
    private var message: String = ""
    private let pythonBridge = PythonBridge()
    
    func callPythonScript(scriptName: String, arguments: [String], completion: @escaping (String?) -> Void) {
        guard let scriptURL = Bundle.main.path(forResource: scriptName, ofType: "py") else {
            completion(nil)
            return
        }

        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
        task.arguments = [scriptURL] + arguments

        let outputPipe = Pipe()
        task.standardOutput = outputPipe

        task.terminationHandler = { _ in
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let response = String(data: outputData, encoding: .utf8)
            DispatchQueue.main.async {
                completion(response)
            }
        }

        do {
            try task.run()
        } catch {
            print("Error running Python script:", error)
            completion(nil)
        }
    }
    func sendMessage() {
            conversation.append("You: \(message)")
            let response = pythonBridge.answerQuestion(vectorIndexFile: "<path_to_vector_index_file>", question: message)
            conversation.append("Chatbot: \(response)")
            message = ""
        }
    func answerQuestion(vectorIndexFile: String, question: String) -> String {
            // TODO: Implement this method
            return ""
        }
}
