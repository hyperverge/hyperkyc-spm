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
            exact: "6.10.0"
        ),
        // CrashGuard dependency
        .package(
            url: "https://github.com/hyperverge/HVCrashGuard",
            exact: "2.1.0"
        )
    ],
    targets: [
        //  Binary target
        .binaryTarget(
            name: "HyperKYCBinary",
            url:  "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.13.0/HyperKYC.xcframework.zip",
            checksum: "8859c141919a31b493ca9bda78ecda1f1a149c9539d054ef78f0b80053f98163"
        ),
    
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
