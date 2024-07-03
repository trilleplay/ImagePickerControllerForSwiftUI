// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImagePickerControllerForSwiftUI",
    platforms: [.iOS(.v13), .visionOS(.v1)],
    products: [
        .library(
            name: "ImagePickerControllerForSwiftUI",
            targets: ["ImagePickerControllerForSwiftUI"]),
    ],
    targets: [
        .target(name: "ImagePickerControllerForSwiftUI")
    ]
)
