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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.29/Mediasoup.xcframework.zip",
            checksum: "f43922f7a7d7b01dab8eabf5e17173bea8fb81fff997ac8a4491b94394cff6b6"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.29/WebRTC.xcframework.zip",
            checksum: "d35f85a2652817c8f2f82938b71d8695b746cab84c85fd2357bb3c434fce4c1b"
        )
    ]
)
