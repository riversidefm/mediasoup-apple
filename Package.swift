// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "MediasoupSwift",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(name: "MediasoupSwift", targets: ["MediasoupSwift"]),
        .library(name: "WebRTC", targets: ["WebRTC"])
    ],
    targets: [
        .target(
            name: "MediasoupSwift",
            dependencies: [
                "Mediasoup",
                "WebRTC"
            ],
            path: "Empty"
        ),
        .binaryTarget(
            name: "Mediasoup",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.27/Mediasoup.xcframework.zip",
            checksum: "40608a94a624ef1c69c3ea5c868ec5b940862d9bd74a04c4058a84894ac93c50"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.27/WebRTC.xcframework.zip",
            checksum: "a720106ba32b4b0562456c444e2f94ce6d07622f1cd070bb3d4b38d27e8e89d5"
        )
    ]
)
