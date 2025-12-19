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
            from: "6.0.0-beta03"
        ),
        // CrashGuard dependency
        .package(
            url: "https://github.com/hyperverge/HVCrashGuard",
            exact: "2.0.0-beta02"
        )
    ],
    targets: [
        // 🔹 Binary target
        // NOTE:
        // - XCFramework filename is still `HyperKYC.xcframework`
        // - Only the SwiftPM *target name* is different to avoid collisions
        .binaryTarget(
            name: "HyperKYCBinary",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYC-Full-1.0.0-XCFramework.zip",
            checksum: "38cbe9fc82088b218965d8d202f5359f56864ac08e4f6ca06dba9059c32c271f"
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
