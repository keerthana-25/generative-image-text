#!/bin/bash

# Configuration
export ANDROID_SDK_ROOT="/tmp/android_toolchain/android_sdk"
export JAVA_HOME="/tmp/android_toolchain/jdk-17.0.10+7/Contents/Home"
export PATH=$PATH:$JAVA_HOME/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools

# Check if SDK exists
if [ ! -d "$ANDROID_SDK_ROOT" ]; then
    echo "Error: Android SDK not found at $ANDROID_SDK_ROOT"
    echo "Please ensure the setup was completed successfully."
    exit 1
fi

# Clean up stale locks
echo "Cleaning up stale emulator locks..."
rm -f ~/.android/avd/test_avd.avd/*.lock

echo "Starting Android Emulator (Pixel API 34)..."
$ANDROID_SDK_ROOT/emulator/emulator -avd test_avd -no-boot-anim -netdelay none -netspeed full &
EMULATOR_PID=$!

echo "Emulator started with PID $EMULATOR_PID"
echo "Waiting for device to be ready..."
$ANDROID_SDK_ROOT/platform-tools/adb wait-for-device

echo "Device ready! You can now run:"
echo "flutter run -d emulator-5554"
