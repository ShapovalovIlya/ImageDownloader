// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageDownloader",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .library(name: "ImageDownloader", targets: ["ImageDownloader"]),
    ],
    targets: [
        .target(name: "ImageDownloader"),
        .testTarget(
            name: "ImageDownloaderTests",
            dependencies: ["ImageDownloader"]),
    ]
)
