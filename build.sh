#!/bin/bash
set -e

APP_NAME="AutoMicLock"
BUILD_DIR="build"
ARCHIVE_PATH="$BUILD_DIR/$APP_NAME.xcarchive"
EXPORT_PATH="$BUILD_DIR/Export"
DMG_NAME="$APP_NAME.dmg"
DMG_PATH="$BUILD_DIR/$DMG_NAME"

echo "🧹 Cleaning previous builds..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

echo "🎨 Generating assets (AppIcon and DMG Background)..."
swift generate_assets.swift

echo "🏗️ Building release archive..."
xcodebuild archive \
    -project "$APP_NAME.xcodeproj" \
    -scheme "$APP_NAME" \
    -configuration Release \
    -archivePath "$ARCHIVE_PATH" \
    -clonedSourcePackagesDirPath .build \
    -quiet

echo "📦 Exporting app..."
EXPORT_PLIST="$BUILD_DIR/ExportOptions.plist"
cat <<EOF > "$EXPORT_PLIST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>mac-application</string>
</dict>
</plist>
EOF

xcodebuild -exportArchive \
    -archivePath "$ARCHIVE_PATH" \
    -exportPath "$EXPORT_PATH" \
    -exportOptionsPlist "$EXPORT_PLIST" \
    -quiet

cp "INSTALL_TUTORIAL.html" "$EXPORT_PATH/"
echo "💿 Creating custom DMG with create-dmg..."
# Remove old dmg if exists
rm -f "$DMG_PATH"

create-dmg \
  --volname "$APP_NAME" \
  --background "build/dmg_background.png" \
  --window-pos 200 120 \
  --window-size 700 400 \
  --icon-size 100 \
  --icon "$APP_NAME.app" 150 200 \
  --hide-extension "$APP_NAME.app" \
  --app-drop-link 350 200 \
  --icon "INSTALL_TUTORIAL.html" 550 200 \
  "$DMG_PATH" \
  "$EXPORT_PATH/"

echo "✅ Build complete! DMG available at $DMG_PATH"
