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
            exact: "6.2.0"
        ),
        // CrashGuard dependency
        .package(
            url: "https://github.com/hyperverge/HVCrashGuard",
            exact: "2.0.0"
        )
    ],
    targets: [
        //  Binary target
        // NOTE:
        // - XCFramework filename is still `HyperKYC.xcframework`
        // - Only the SwiftPM *target name* is different to avoid collisions
        .binaryTarget(
            name: "HyperKYCBinary",
            url: "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.3.0/HyperKYC.xcframework.zip",
            checksum: "036446b46dd14e76a1bcd90d9e68c37614779f7a28eb63b60a1f68bc67ac2a4b"
        ),

        // Wrapper target (owns resources)
        // HyperKYCPreview.storyboardc is pre-compiled so clients never run ibtool
        // and never see storyboard warnings in their Xcode projects.
        // .storyboardc lives at the target root (not inside Resources/) so that
        // .copy places it at the bundle root where UIStoryboard can find it.
        .target(
            name: "HyperKYCWrapper",
            dependencies: [
                "HyperKYCBinary",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm"),
                .product(name: "HVCrashGuard", package: "HVCrashGuard")
            ],
            path: "Sources/HyperKYCWrapper",
            resources: [
                .copy("HyperKYCPreview.storyboardc"),
                .process("Resources")
            ]
        )
    ]
)
