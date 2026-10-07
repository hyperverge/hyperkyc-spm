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
            exact: "6.8.0"
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
            url:  "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.10.1/HyperKYC.xcframework.zip",
            checksum: "3284bc1fce3da96f5c16f881e1a66d042c41e10fa98f038bce2bc97ab8af9a0c"
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
