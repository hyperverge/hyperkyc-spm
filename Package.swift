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
            from: "6.0.0-beta02"
        ),
        // Pull in HVCrashGuard (used only by Full variant)
        .package(
            url: "https://github.com/hyperverge/HVCrashGuard",
            from: "2.0.0-beta"
        )
    ],
    targets: [
        // Binary target for HyperKYC Full (XCFramework with HVCrashGuard)
        .binaryTarget(
            name: "HyperKYC",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYC-Full-1.0.0-XCFramework.zip",
            checksum: "a580f7c30d2d4900fc477ff33709196f44174037ccb65a88d91a248cc2f86289"
        ),

        // Binary target for HyperKYC Core (XCFramework without HVCrashGuard)
        .binaryTarget(
            name: "HyperKYCCore",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYCCore-1.0.0-XCFramework.zip",
            checksum: "fbc25e94f5357134ab08743b797338184e9edfdad184a29d08e35bc66801065d"
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
