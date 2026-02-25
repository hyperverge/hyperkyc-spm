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
            url: "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.1.0/HyperKYC.xcframework.zip",
            checksum: "44f2681354745ba26231390404949208bc6b3f250dc187413609ce02f6c6d4e1"
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
