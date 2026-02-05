// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HyperKYC",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Public product exposed to clients
        .library(
            name: "HyperKYC",
            targets: ["HyperKYCWrapper"]
        )
    ],
    dependencies: [
        // HyperSnapSDK dependency
        .package(
            url: "https://github.com/hyperverge/hypersnapsdk-spm",
            from: "6.0.1"
        ),
        // CrashGuard dependency
        .package(
            url: "https://github.com/hyperverge/HVCrashGuard",
            exact: "2.0.0"
        )
    ],
    targets: [
        // 🔹 Binary target
        // NOTE:
        // - XCFramework filename is still `HyperKYC.xcframework`
        // - Only the SwiftPM *target name* is different to avoid collisions
        .binaryTarget(
            name: "HyperKYCBinary",
            url: "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYC.xcframework.zip",
            checksum: "4ba2141a9421778816585eaf4c4f8bcc5f08014f533d34f40dd8f2d430b943ae"
        ),

        // 🔹 Wrapper target (owns resources)
        .target(
            name: "HyperKYCWrapper",
            dependencies: [
                "HyperKYCBinary",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm"),
                .product(name: "HVCrashGuard", package: "HVCrashGuard")
            ],
            path: "Sources/HyperKYCWrapper",
            resources: [
                // Correct choice for this repo
                .process("Resources")
            ]
        )
    ]
)
