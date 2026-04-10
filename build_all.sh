#!/bin/bash
set -e

export PROJECT_DIR="$(pwd)"
echo "PROJECT_DIR = $PROJECT_DIR"
export BUILD_DIR="$(pwd)/build"
echo "BUILD_DIR = $BUILD_DIR"
export OUTPUT_DIR="$(pwd)/bin"
echo "OUTPUT_DIR = $OUTPUT_DIR"

./build_ios.sh --no-interactive
./build_macos.sh --no-interactive

echo "create WebRTC.xcframework"
rm -rf "$OUTPUT_DIR/WebRTC.xcframework"

ABSOLUTE_OUTPUT_DIR="$(cd "$OUTPUT_DIR" && pwd)"
xcodebuild -create-xcframework \
    -framework "$ABSOLUTE_OUTPUT_DIR/mac/WebRTC.framework" \
    -debug-symbols "$ABSOLUTE_OUTPUT_DIR/mac/WebRTC.dSYM" \
    -framework "$ABSOLUTE_OUTPUT_DIR/ios/WebRTC.framework" \
    -debug-symbols "$ABSOLUTE_OUTPUT_DIR/ios/WebRTC.dSYM" \
    -framework "$ABSOLUTE_OUTPUT_DIR/ios/simulator/WebRTC.framework" \
    -debug-symbols "$ABSOLUTE_OUTPUT_DIR/ios/simulator/WebRTC.dSYM" \
    -output "$ABSOLUTE_OUTPUT_DIR/WebRTC.xcframework"

# Create tar file with the internal include files from webrtc, compressed
rm -rf "$OUTPUT_DIR/WebRTC-includes.tar.gz"
find Mediasoup/dependencies/webrtc/src -name "*.h" -o -name "*.hpp" | tar -zcf "$OUTPUT_DIR/WebRTC-includes.tar.gz" -T -

echo "create mediasoupclient-headers.tar.gz"
rm -rf "$OUTPUT_DIR/mediasoupclient-headers.tar.gz"
find Mediasoup/dependencies/libmediasoupclient/include -name "*.h" -o -name "*.hpp" | tar -zcf "$OUTPUT_DIR/mediasoupclient-headers.tar.gz" -T -

echo "create sdptransform-headers.tar.gz"
rm -rf "$OUTPUT_DIR/sdptransform-headers.tar.gz"
find Mediasoup/dependencies/libmediasoupclient/deps/libsdptransform/include -name "*.h" -o -name "*.hpp" | tar -zcf "$OUTPUT_DIR/sdptransform-headers.tar.gz" -T -

echo "create mediasoupclient.xcframework"
rm -rf "$OUTPUT_DIR/mediasoupclient.xcframework"
xcodebuild -create-xcframework \
    -library "$OUTPUT_DIR/mac/libmediasoupclient.a" \
    -library "$OUTPUT_DIR/ios/libmediasoupclient.a" \
    -library "$OUTPUT_DIR/ios/simulator/libmediasoupclient.a" \
    -output "$OUTPUT_DIR/mediasoupclient.xcframework"

echo "create sdptransform.xcframework"
rm -rf "$OUTPUT_DIR/sdptransform.xcframework"
xcodebuild -create-xcframework \
    -library "$OUTPUT_DIR/mac/libsdptransform.a" \
    -library "$OUTPUT_DIR/ios/libsdptransform.a" \
    -library "$OUTPUT_DIR/ios/simulator/libsdptransform.a" \
    -output "$OUTPUT_DIR/sdptransform.xcframework"

./build_bindings.sh
