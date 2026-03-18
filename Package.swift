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
            checksum: "4e558db91eb73e3770b0e025a59b63a73375c31fd90125e659e1547e1b47bba7"
        ),
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/riversidefm/mediasoup-apple/releases/download/1.0.23/WebRTC.xcframework.zip",
            checksum: "ac878c1adbe7afc0f35b6f68cabd83b854aee4466ea79a9a53a020a01910d9f9"
        )
    ]
)
