// swift-tools-version: 6.1

import PackageDescription

let package = Package(
    name: "AimstarInAppLogSDK",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "AimstarInAppLogSDK",
            targets: ["AimstarInAppLogSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "AimstarInAppLogSDK",
            url: "https://github.com/supsysjp/aimstar-in-app-log-ios/releases/download/1.0.1/AimstarInAppLogSDK.zip",
            checksum: "e53d2e2655a992cb0192a983cff6e2e3054a70a374a668dd1ec16f4c491e8629"
        ),
    ],
)
