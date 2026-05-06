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
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.31/Mediasoup.xcframework.zip",
            checksum: "8e499f02d44a12ace759c3819f69d2d13752ae4fe5e8e831b74e0dcc1f1372ec"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.31/WebRTC.xcframework.zip",
            checksum: "c49186ec273216d51dd4f5694becddb2562f440a39bdbeb7108e76e2a498cd6a"
        )
    ]
)
