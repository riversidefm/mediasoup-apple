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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.23/Mediasoup.xcframework.zip",
            checksum: "d5b8d7ab907cd62511dea18c671b94edd308de988d42285a8d1a78c07bd081d1"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.23/WebRTC.xcframework.zip",
            checksum: "bfa5131f8e873eb9af5ea9d1c1c9859630702f9cd0c6318f80a403b3a5e0cb56"
        )
    ]
)
