#!/bin/bash
set -e

echo "🚀 Installing AutoMicLock..."

# In a real-world scenario, this would download from a GitHub Release
# DMG_URL="https://github.com/yourusername/automiclock/releases/latest/download/AutoMicLock.dmg"
# curl -sSL -o /tmp/AutoMicLock.dmg "$DMG_URL"

# For local demonstration, we use the locally built DMG
if [ ! -f "build/AutoMicLock.dmg" ]; then
    echo "❌ Error: build/AutoMicLock.dmg not found. Please run ./build.sh first."
    exit 1
fi

cp "build/AutoMicLock.dmg" /tmp/AutoMicLock.dmg

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
