# Auto MicLock 🔒🎙️

**Lock your internal microphone. Unlock HD audio quality.**

**The Problem:** macOS automatically switches your microphone input to Bluetooth devices when they connect. This forces your headphones (AirPods, Bose, Sony, Beats) into a low-bandwidth "Hands-Free" profile, instantly ruining your audio quality and making everything sound muffled like a bad phone call.

**The Solution:** Auto MicLock keeps your Mac’s built-in microphone permanently selected. It is a lightweight macOS Menu Bar utility that prevents unwanted automatic input switching. 

By forcing macOS to ignore the headset's microphone, your Bluetooth headphones remain in high-fidelity mode (AAC/SBC), ensuring you maintain crystal-clear HD audio for your ears while using the Mac's superior internal mic for your voice. Perfect for Zoom, Teams, Google Meet, Discord, or listening to music while gaming.

*(Keywords: macOS auto switch microphone to bluetooth, stop mac from changing audio input, prevent AirPods from changing mic, fix bad audio quality bluetooth mac, force internal microphone macos, disable hands free profile mac, lock audio input mac, macos audio input keeps changing, bluetooth sound quality drops when mic is used).*

## Features

- **Auto-Switch Protection**: Instantly reverts any automatic microphone changes back to the internal mic.
- **HD Audio Preservation**: Keeps your Bluetooth headphones in high-fidelity mode (AAC/SBC) instead of the muffled "telephone" quality.
- **Launch at Login**: Native macOS integration to start automatically in the background.
- **Auto-Updates**: Built-in update mechanism via Sparkle.
- **Lightweight**: Pure Swift and CoreAudio implementation with zero impact on system resources.

## Installation

### Method 1: Download the App (Recommended)
1. Download the latest `AutoMicLock.dmg` from the [Releases](../../releases) page.
2. Open the DMG and drag the app into your Applications folder.
3. Launch it and click the Menu Bar icon to enable the lock.

### Method 2: One-Line Terminal Install
Run this command in your terminal to install the application instantly:
```bash
curl -fsSL https://raw.githubusercontent.com/BFMIX/AutoMicLock/main/install.sh | bash
```

## Development

The project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) to manage the Xcode project without merge conflicts.

```bash
# Generate the Xcode project
xcodegen

# Build the release DMG
./build.sh
```

## License
[MIT License](LICENSE)
