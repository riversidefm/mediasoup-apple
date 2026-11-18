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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.36/Mediasoup.xcframework.zip",
            checksum: "4838b0230cbfc64241f9cfbb67ec647730cb303d66924c92c95faafa05b4cc77"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.36/WebRTC.xcframework.zip",
            checksum: "eb1985ff7b56561c5fc6deffd7d8f6854a5bcd35ba6e96f183f3afcce65cc436"
        )
    ]
)
