// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HyperKYC",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Full product: HyperKYC + HyperSnapSDK + HVCrashGuard (DEFAULT)
        .library(
            name: "HyperKYC",
            targets: ["HyperKYCWrapper"]
        ),
        // Core product: HyperKYC + HyperSnapSDK only (no CrashGuard)
        .library(
            name: "HyperKYCCore",
            targets: ["HyperKYCCoreWrapper"]
        )
    ],
    dependencies: [
        // Pull in HyperSnapSDK from its SPM-friendly tag
        .package(
            url: "https://github.com/hyperverge/hypersnapsdk-spm",
            from: "6.0.0-beta03"
        ),
        // Pull in HVCrashGuard (used only by Full variant)
        .package(
            url: "https://github.com/hyperverge/HVCrashGuard",
            exact: "2.0.0-beta"
        )
    ],
    targets: [
        // Binary target for HyperKYC Full (XCFramework with HVCrashGuard)
        .binaryTarget(
            name: "HyperKYC",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYC-Full-1.0.0-XCFramework.zip",
            checksum: "61b57b50ae7dde846c6bd475ad57f427869ffc6c4c733f0065a63d27d6297c66"
        ),

        // Binary target for HyperKYC Core (XCFramework without HVCrashGuard)
        .binaryTarget(
            name: "HyperKYCCore",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYCCore-1.0.0-XCFramework.zip",
            checksum: "6d9397b490ad9ea27e1a85c95502546e3273c272ccc1f9294b7d304cc8b454a8"
        ),

        // Full wrapper: HyperKYC + HyperSnapSDK + CrashGuard
        .target(
            name: "HyperKYCWrapper",
            dependencies: [
                "HyperKYC",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm"),
                .product(name: "HVCrashGuard", package: "HVCrashGuard")
            ],
            path: "Sources/HyperKYCWrapper",
            resources: [
                .process("Resources")
            ]
        ),

        // Core wrapper: HyperKYCCore + HyperSnapSDK only
        .target(
            name: "HyperKYCCoreWrapper",
            dependencies: [
                "HyperKYCCore",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm")
            ],
            path: "Sources/HyperKYCCoreWrapper",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
