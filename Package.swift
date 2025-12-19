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
            exact: "2.0.0-beta02"
        )
    ],
    targets: [
        // Binary target for HyperKYC Full (XCFramework with HVCrashGuard)
        .binaryTarget(
            name: "HyperKYC",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYC-Full-1.0.0-XCFramework.zip",
            checksum: "38cbe9fc82088b218965d8d202f5359f56864ac08e4f6ca06dba9059c32c271f"
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
                .copy("Resources")
            ]
        )
    ]
)
