//
//  MacGPTApp.swift
//  MacGPT
//
//  Created by Daniel Santiago on 4/18/23.
//

import SwiftUI

@main
struct MacGPTApp: App {
    init() {
        createAppFolders()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func createAppFolders() {
        let fileManager = FileManager.default

        guard let appSupportURL = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            print("Error: Unable to find Application Support folder.")
            return
        }

        let appName = "MacGPT"
        let appSupportFolder = appSupportURL.appendingPathComponent(appName)
        let textFilesFolder = appSupportFolder.appendingPathComponent("TextFiles")

        do {
            try fileManager.createDirectory(at: appSupportFolder, withIntermediateDirectories: true, attributes: nil)
            try fileManager.createDirectory(at: textFilesFolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error: Unable to create directories: \(error)")
        }
    }
}
