# Auto MicLock 🔒🎙️

**Lock your internal microphone. Unlock HD audio quality.**

Auto MicLock is a lightweight macOS Menu Bar utility that forces your system to always use the internal microphone, even when Bluetooth headphones (AirPods, Bose, Sony, etc.) are connected. 

By preventing macOS from switching the input source to your headset, it stops your headphones from entering the low-quality "Hands-Free" mode, ensuring you maintain crystal-clear HD audio for your ears while using the Mac's superior internal mic for your voice.

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
