#!/bin/bash
set -e

echo "🚀 Installing AutoMicLock..."

DMG_URL="https://github.com/BFMIX/AutoMicLock/releases/latest/download/AutoMicLock.dmg"
echo "📥 Downloading latest release..."
curl -sSL -o /tmp/AutoMicLock.dmg "$DMG_URL"

echo "💿 Mounting image..."
hdiutil attach /tmp/AutoMicLock.dmg -mountpoint /Volumes/AutoMicLock -nobrowse -quiet

echo "📦 Copying to /Applications..."
# Remove existing version if present
if [ -d "/Applications/AutoMicLock.app" ]; then
    rm -rf "/Applications/AutoMicLock.app"
fi
cp -R /Volumes/AutoMicLock/AutoMicLock.app /Applications/

echo "🧹 Cleaning up..."
hdiutil detach /Volumes/AutoMicLock -quiet
rm /tmp/AutoMicLock.dmg

echo "✅ AutoMicLock installed successfully!"
echo "👉 You can now launch it from your Applications folder."
