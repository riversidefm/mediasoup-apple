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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.35/Mediasoup.xcframework.zip",
            checksum: "bf2c2f49bbad7a29c3bdcae93bb075ca341a83e6c6fbd8fdce69484e5e405a91"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.35/WebRTC.xcframework.zip",
            checksum: "ef02d0938ba67df587c51f9afb97694ca171e4eaf3b684dd4164f42c8fbb423f"
        )
    ]
)
