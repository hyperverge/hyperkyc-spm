// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HyperKYC",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Public SDK that clients import
        .library(
            name: "HyperKYC",
            targets: ["HyperKYCWrapper"]
        )
    ],
    
    dependencies: [
        .package( url: "https://github.com/hyperverge/hypersnapsdk-spm", from: "6.0.0-beta03" ),
        // Pull in HVCrashGuard (used only by Full variant)
        .package( url: "https://github.com/hyperverge/HVCrashGuard", exact: "2.0.0-beta" )
    ],
        
    targets: [
        // Binary XCFramework (module name = HyperKYC)
        .binaryTarget(
            name: "HyperKYC",
            url: "https://hvsdk.s3.ap-south-1.amazonaws.com/ios/release/hyperkyc/1.0.0/HyperKYC-Full-1.0.0-XCFramework.zip",
            checksum: "e0c4ce7b57b8a288a37e26b253d857a8cae513ba4a403330c432c6582f1d98c0"
        ),

        // Thin wrapper ONLY for resources
        .target(
            name: "HyperKYCWrapper",
            dependencies: [ "HyperKYC",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm"), .product(name: "HVCrashGuard", package: "HVCrashGuard") ],
            path: "Sources/HyperKYCWrapper",
            resources: [ .process("Resources")
                       ] ),
    ]
)
