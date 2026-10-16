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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.33/Mediasoup.xcframework.zip",
            checksum: "1c6094d39d9d6025d0fad2f3aae620b04f9d06f6776c13da2a84b9c384af86f7"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.33/WebRTC.xcframework.zip",
            checksum: "0771324bf03a42a9d2a688761025a1942ad9d2a9b025d10c6b104d4a16dc0964"
        )
    ]
)
