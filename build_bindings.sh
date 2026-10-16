#! /bin/bash
set -e


SRCROOT=$(pwd)
PROJECT_NAME="Mediasoup"
FRAMEWORK_NAME="Mediasoup"
BUILD_DIR="${SRCROOT}/build/Mediasoup"
OUTPUT_DIR="${SRCROOT}/bin"

# Remove build directory if it exists
if [ -d "${BUILD_DIR}" ]; then
	rm -rf "${BUILD_DIR}"
fi

# Build the framework for both device and simulator
xcodebuild -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${FRAMEWORK_NAME}" \
    -configuration Release \
    -arch arm64 only_active_arch=no \
    -sdk "iphoneos" \
    -derivedDataPath "${BUILD_DIR}"

xcodebuild -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${FRAMEWORK_NAME}" \
    -configuration Release \
    -arch arm64 only_active_arch=no \
    -sdk "iphonesimulator" \
    -derivedDataPath "${BUILD_DIR}"

# Build the macOS framework for arm64 only.
xcodebuild -project "${PROJECT_NAME}.xcodeproj" \
    -scheme "${FRAMEWORK_NAME}" \
    -configuration Release \
    -destination 'generic/platform=macOS' \
    -derivedDataPath "${BUILD_DIR}"

# Strip local symbols now that the dSYMs exist. Crash reports are symbolicated
# from the dSYM, matched by UUID, and `strip -x` keeps the UUID and the global
# symbols dyld binds to. realpath resolves the macOS Versions/Current symlink.
# Stripping breaks an existing signature, so a slice that had a valid one is
# ad hoc signed again
for PRODUCTS_DIR in Release-iphoneos Release-iphonesimulator Release; do
	FRAMEWORK="${BUILD_DIR}/Build/Products/${PRODUCTS_DIR}/${FRAMEWORK_NAME}.framework"
	SIGNED=false
	if codesign --verify "${FRAMEWORK}" 2>/dev/null; then
		SIGNED=true
	fi
	xcrun strip -x "$(realpath "${FRAMEWORK}/${FRAMEWORK_NAME}")"
	if [ "${SIGNED}" = true ]; then
		codesign --force --sign - "${FRAMEWORK}"
	fi
done

# Prepare output directory
mkdir -p ${OUTPUT_DIR}
if [ -d "${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework" ]; then
	rm -rf "${OUTPUT_DIR}/${FRAMEWORK_NAME}.xcframework"
fi

xcodebuild -create-xcframework \
	-framework ${BUILD_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework \
    -debug-symbols ${BUILD_DIR}/Build/Products/Release-iphoneos/${FRAMEWORK_NAME}.framework.dSYM \
	-framework ${BUILD_DIR}/Build/Products/Release-iphonesimulator/${FRAMEWORK_NAME}.framework \
    -debug-symbols ${BUILD_DIR}/Build/Products/Release-iphonesimulator/${FRAMEWORK_NAME}.framework.dSYM \
	-framework ${BUILD_DIR}/Build/Products/Release/${FRAMEWORK_NAME}.framework \
    -debug-symbols ${BUILD_DIR}/Build/Products/Release/${FRAMEWORK_NAME}.framework.dSYM \
	-output $OUTPUT_DIR/${FRAMEWORK_NAME}.xcframework
