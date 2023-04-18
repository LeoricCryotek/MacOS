import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        
        createAppFolders()

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)

        // Override point for customization after application launch.
    }
    
    // Other AppDelegate methods...

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
