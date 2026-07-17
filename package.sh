#!/bin/bash
# Builds a release binary and packages it as a menu bar app in /Applications.
# Re-run after code changes; quit the running app first or the copy will fail.
set -euo pipefail

APP_NAME="Claude Usage"
BINARY="claude-usage-menu-bar"
APP="/Applications/${APP_NAME}.app"

swift build -c release

if pgrep -x "$BINARY" > /dev/null; then
    echo "'${APP_NAME}' is running. Quit it from the menu bar, then re-run."
    exit 1
fi

rm -rf "$APP"
mkdir -p "${APP}/Contents/MacOS"
cp ".build/release/${BINARY}" "${APP}/Contents/MacOS/"

cat > "${APP}/Contents/Info.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleExecutable</key>
	<string>${BINARY}</string>
	<key>CFBundleIdentifier</key>
	<string>com.marumakes.claude-usage-menu-bar</string>
	<key>CFBundleName</key>
	<string>${APP_NAME}</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>LSMinimumSystemVersion</key>
	<string>15.0</string>
	<key>LSUIElement</key>
	<true/>
</dict>
</plist>
PLIST

open "$APP"
echo "Installed and launched ${APP}"
echo "To start it at login: System Settings > General > Login Items & Extensions"
