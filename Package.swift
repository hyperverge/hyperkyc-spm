// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "HyperKYC",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // The library your clients will import:
        .library(
            name: "HyperKYC",
            targets: ["HyperKYCWrapper"]
        )
    ],
    dependencies: [
        // Pull in HyperSnapSDK from its SPM-friendly tag
        // Uses the tag 5.0.0
             .package(
                 url: "https://github.com/hyperverge/hypersnapsdk-spm",
                 from: "5.0.0"
             )
    ],
    targets: [
        // 1) Your static HyperKYC XCFramework
        .binaryTarget(
            name: "HyperKYC",
            path: "Core/HyperKYC.xcframework"
        ),

        // 2) A Swift "wrapper" target that:
        //    • Depends on both your XCFramework and HyperSnapSDK
        //    • Processes your resource folder (Resources/)
        .target(
            name: "HyperKYCWrapper",
            dependencies: [
                "HyperKYC",
                .product(name: "HyperSnapSDK", package: "hypersnapsdk-spm")
            ],
            path: "Sources/HyperKYCWrapper",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
