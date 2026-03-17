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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/0.0.1/Mediasoup.xcframework.zip",
            checksum: "d5b8d7ab907cd62511dea18c671b94edd308de988d42285a8d1a78c07bd081d1"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/0.0.1/WebRTC.xcframework.zip",
            checksum: "bdc6f2a80c3dca13743a7e3ab19dad044058a6b2efabec98a5d1aed3c39794b7"
        )
    ]
)
