#!/bin/bash
set -e

# $1 = plugin, $2 = target (debug|release), $3 = Godot version
#
# arm64 DEVICE only. Godot 4 / modern iOS SDKs dropped armv7 (32-bit), and the GPS spike
# runs on a real iPhone, so we skip the simulator + armv7 slices the original script built
# (they only broke the build). Re-add a simulator slice later if you ever run in the iOS
# Simulator.

# Compile the arm64 device static library.
scons target=$2 arch=arm64 plugin=$1 version=$3

# One-arch "fat" lib (lipo with a single input is valid) → the name the xcframework expects.
lipo -create "./bin/lib$1.arm64-ios.$2.a" -output "./bin/$1-device.$2.a"

# Package it as an .xcframework.
xcodebuild -create-xcframework \
    -library "./bin/$1-device.$2.a" \
    -output "./bin/$3/$1.$2.xcframework"
