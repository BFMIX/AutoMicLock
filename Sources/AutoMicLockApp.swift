import SwiftUI
import Sparkle

@main
struct AutoMicLockApp: App {
    @StateObject private var audioController = AudioController()
    private let updaterController: SPUStandardUpdaterController

    init() {
        // Initialize Sparkle Updater
        updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
    }

    var body: some Scene {
        MenuBarExtra {
            ContentView(audioController: audioController, updater: updaterController.updater)
        } label: {
            Image(systemName: audioController.isMicLocked ? "mic.fill" : "mic.slash.fill")
                // On macOS, Menu Bar icons are templates by default. We use palette/multicolor 
                // and foregroundStyle to attempt forcing color, but system behavior may override.
                .symbolRenderingMode(.palette)
                .foregroundStyle(audioController.isMicLocked ? .green : .red, .primary)
        }
        .menuBarExtraStyle(.window) // Uses a popover window instead of a standard menu
    }
}
