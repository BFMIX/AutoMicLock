# Auto MicLock : (Force macOS to Use Built-in Microphone 🔒🎙️)

**[🌐 Visit the Official Website](https://bfmix.github.io/AutoMicLock/)**

**Fix automatic microphone switching on Mac and improve audio quality in calls.**

Auto MicLock is a lightweight macOS Menu Bar utility that prevents your Mac from automatically switching the microphone input to Bluetooth headphones when they connect. By keeping the Mac’s built-in microphone permanently selected, it stops your headphones from entering low-quality audio modes, ensuring crystal-clear sound during calls, meetings, and recordings.

## The Problem: Why Does macOS Change My Microphone?

Whenever you connect Bluetooth headphones to your Mac, macOS automatically switches both the audio output and the audio input (microphone) to that device. 

Because of Bluetooth bandwidth limitations, activating the headset's microphone forces the connection into a low-quality "Hands-Free Profile" (HFP/HSP). This instantly ruins your audio quality, making everything sound muffled and distorted like a bad phone call. 

## The Solution

**Auto MicLock** silently monitors your system's audio settings. If macOS attempts to switch the input to your Bluetooth headset, Auto MicLock instantly forces the input back to your Mac's superior built-in microphone.

By forcing macOS to ignore the headset's microphone, your Bluetooth connection remains in high-fidelity mode (AAC/SBC). 

👉 **The result:** You maintain crystal-clear, stable audio quality for your ears, while using the Mac's excellent internal microphone for your voice.

## Use Cases

Auto MicLock is perfect for anyone who wants to maintain stable, high-quality audio while using:
- **Zoom** meetings
- **Microsoft Teams** calls
- **Google Meet** conferences
- **Discord** voice chats
- **OBS Studio** recordings and streaming
- General music listening while gaming or working

## Supported Devices

Auto MicLock works universally with any Bluetooth audio device that triggers the macOS auto-switch behavior, including:
- **Apple:** AirPods, AirPods Pro, AirPods Max, Beats
- **Sony:** WH-1000XM series, WF-1000XM series
- **Bose:** QuietComfort, Noise Cancelling Headphones
- **Jabra:** QuietComfort series
- **Generic:** Any standard Bluetooth headset or earbuds

## Features

- **Auto-Switch Prevention**: Instantly reverts automatic microphone changes back to the internal mic.
- **Audio Quality Preservation**: Keeps your headphones in high-fidelity mode instead of muffled "telephone" quality.
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

## Frequently Asked Questions (FAQ)

**Why does my audio quality drop when I join a call with AirPods on Mac?**
Bluetooth has limited bandwidth. When the microphone is activated, macOS switches from high-quality audio (A2DP) to a lower-quality two-way profile (HFP). Auto MicLock prevents this by forcing the Mac to use its internal microphone instead.

**Do I need to keep the app open?**
Auto MicLock runs silently in your macOS Menu Bar. You can set it to "Launch at Login" so you never have to think about it again.

**Is this safe and open source?**
Yes. Auto MicLock uses native macOS CoreAudio APIs. It does not collect data, has no network telemetry (other than checking for updates), and the entire source code is available here.

## How it works (Under the hood)

Unlike hacky scripts that run infinite loops in the background, Auto MicLock is a **100% native macOS application** written in pure Swift.

- **CoreAudio Event-Driven**: It uses native `AudioObjectAddPropertyListenerBlock` to listen for hardware changes. It only wakes up when macOS tries to change the default input, meaning **0% CPU usage** on standby.
- **No External Dependencies**: It does not rely on Automator, SwitchAudioSource, or bash loops. It directly sets the `kAudioDeviceTransportTypeBuiltIn` device via low-level system APIs.
- **SMAppService**: Uses the modern macOS background service API to launch silently at login without creating messy `LaunchAgents` or plist files.

```bash
# Generate the Xcode project
xcodegen

# Build the release DMG
./build.sh
```

## License
[MIT License](LICENSE)
