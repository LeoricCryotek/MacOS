import Foundation
import PythonKit

class PythonBridge {
    
    private let sys = Python.import("sys")
    
    init() {
        // Get the path to the folder containing the Python scripts
        let scriptFolder = Bundle.main.resourceURL?.appendingPathComponent("Python").path
        sys.path.append(scriptFolder ?? "")
    }
    
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

    func sendMessage(apiKey: String, message: String, completion: @escaping (String) -> Void) {
        let response = answerQuestion(apiKey: apiKey, vectorIndexFile: "~/Library/Application Support/MacGPT/TextFiles", question: message)
        completion(response)
    }

    func answerQuestion(apiKey: String, vectorIndexFile: String, question: String) -> String {
        let gpt_index_chatbot = Python.import("gpt_index_chatbot")
        let response = gpt_index_chatbot.answer_question(apiKey: apiKey, vector_index_file: vectorIndexFile, question: question)
        return String(describing: response)
    }
}
