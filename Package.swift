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
            exact: "6.7.0"
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
            url:  "https://hvsdk.s3.amazonaws.com/ios/release/hyperkyc/1.9.0/HyperKYC.xcframework.zip",
            checksum: "68b8dcd8ce32d0600b3aae2867e62f57b79835f85bb5a22654846526e60dd18c"
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
