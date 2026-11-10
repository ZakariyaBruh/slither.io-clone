#!/bin/bash
# Build MyLib.dylib for iOS (arm64). Requires macOS with Xcode installed.
set -euo pipefail
cd "$(dirname "$0")"

SDK=$(xcrun --sdk iphoneos --show-sdk-path)
MIN_IOS=${MIN_IOS:-13.0}

xcrun --sdk iphoneos clang \
  -arch arm64 \
  -isysroot "$SDK" \
  -miphoneos-version-min="$MIN_IOS" \
  -fobjc-arc -fvisibility=hidden \
  -dynamiclib -install_name @rpath/MyLib.dylib \
  -framework Foundation \
  MyLib.m -o MyLib.dylib

# iOS requires dylibs to be code-signed. Use your identity (or "-" for ad-hoc on jailbroken/dev setups).
codesign -f -s "${CODESIGN_IDENTITY:--}" MyLib.dylib
echo "Built $(pwd)/MyLib.dylib"
