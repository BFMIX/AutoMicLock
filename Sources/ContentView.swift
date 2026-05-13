import SwiftUI
import ServiceManagement
import Sparkle

struct ContentView: View {
    @ObservedObject var audioController: AudioController
    let updater: SPUUpdater
    @State private var launchAtLogin = SMAppService.mainApp.status == .enabled
    @State private var isPulsing = false

    var body: some View {
        VStack(spacing: 0) {
            // Animated Premium Header
            ZStack {
                // Background Gradient animated based on lock state
                LinearGradient(
                    gradient: Gradient(colors: audioController.isMicLocked ? [Color.blue.opacity(0.8), Color.purple.opacity(0.8)] : [Color.gray.opacity(0.4), Color.gray.opacity(0.2)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .animation(.easeInOut(duration: 0.6), value: audioController.isMicLocked)
                
                VStack(spacing: 12) {
                    // Pulsing Lock Icon
                    ZStack {
                        Circle()
                            .fill(audioController.isMicLocked ? Color.green : Color.red)
                            .frame(width: 56, height: 56)
                            .shadow(color: audioController.isMicLocked ? .green.opacity(0.6) : .red.opacity(0.6), radius: isPulsing ? 12 : 3)
                            .scaleEffect(isPulsing ? 1.08 : 1.0)
                            .animation(audioController.isMicLocked ? .easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default, value: isPulsing)
                        
                        Image(systemName: audioController.isMicLocked ? "lock.fill" : "lock.open.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .animation(.spring(response: 0.4, dampingFraction: 0.6, blendDuration: 0), value: audioController.isMicLocked)
                    }
                    .padding(.top, 16)
                    .onAppear {
                        if audioController.isMicLocked { isPulsing = true }
                    }
                    .onChange(of: audioController.isMicLocked) { locked in
                        isPulsing = locked
                    }
                    
                    // Title & Status
                    VStack(spacing: 4) {
                        Text("Auto MicLock")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        
                        if audioController.isMicLocked {
                            Text("Mac internal mic is active")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white.opacity(0.9))
                            Text("Enjoy HD Audio Quality")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.white.opacity(0.8))
                        } else {
                            Text("Protection Disabled")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.white.opacity(0.8))
                            Text("Headset mic may reduce audio quality")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.white.opacity(0.6))
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(height: 160)
            
            // Interactive Settings List
            VStack(spacing: 24) {
                // Mic Lock Toggle
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Microphone Lock")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Forces internal mic to preserve HD audio")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Toggle("", isOn: $audioController.isMicLocked)
                        .toggleStyle(.switch)
                        .labelsHidden()
                        .tint(.purple)
                }
                
                Divider()
                
                // Launch at Login Toggle
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Start at Login")
                            .font(.system(size: 14, weight: .semibold))
                        Text("Run automatically in the background")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { self.launchAtLogin },
                        set: { newValue in
                            self.launchAtLogin = newValue
                            do {
                                if newValue {
                                    if SMAppService.mainApp.status != .enabled { try SMAppService.mainApp.register() }
                                } else {
                                    if SMAppService.mainApp.status == .enabled { try SMAppService.mainApp.unregister() }
                                }
                            } catch {
                                print("Failed to update login status")
                                self.launchAtLogin = SMAppService.mainApp.status == .enabled
                            }
                        }
                    ))
                    .toggleStyle(.switch)
                    .labelsHidden()
                    .tint(.blue)
                }
            }
            .padding(24)
            .background(Color(NSColor.windowBackgroundColor))
            
            // Footer Toolbar
            HStack {
                Button(action: {
                    updater.checkForUpdates()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                        Text("Check for Updates")
                    }
                }
                .buttonStyle(.plain)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.red.opacity(0.8))
                .keyboardShortcut("q")
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 14)
            .background(Color(NSColor.controlBackgroundColor))
        }
        .frame(width: 320)
    }
}
