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
        MenuBarExtra("AutoMicLock", systemImage: "mic.fill") {
            ContentView(audioController: audioController, updater: updaterController.updater)
        }
        .menuBarExtraStyle(.window) // Uses a popover window instead of a standard menu
    }
}
