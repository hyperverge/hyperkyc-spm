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
            exact: "6.1.0"
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
            url: "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.2.0/HyperKYC.xcframework.zip",
            checksum: "2922f7383445ac5f04cb27c7a8d544cfc155bc16a27834c9c8a0531efa6cc8fa"
        ),

        // Wrapper target (owns resources)
        .target(
            name: "HyperKYCWrapper",
            dependencies: [
                "HyperKYCBinary",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm"),
                .product(name: "HVCrashGuard", package: "HVCrashGuard")
            ],
            path: "Sources/HyperKYCWrapper",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
