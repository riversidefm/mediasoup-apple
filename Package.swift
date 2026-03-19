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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.25/Mediasoup.xcframework.zip",
            checksum: "c5fb9fe5874d4b414e85e9e28c012861c58387dbf0f68f99f974296d3e58d327"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.25/WebRTC.xcframework.zip",
            checksum: "ee51c67679d672b1e9c4bd5b7ca374e2a840aa506544d09e2823371dadfc37df"
        )
    ]
)
