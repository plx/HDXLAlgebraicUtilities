// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HDXLAlgebraicUtilities",
  platforms: [
    SupportedPlatform.iOS(.v15),
    SupportedPlatform.macOS(.v12),
    SupportedPlatform.tvOS(.v15),
    SupportedPlatform.watchOS(.v8)
  ],
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "HDXLAlgebraicUtilities",
      targets: ["HDXLAlgebraicUtilities"]),
  ],
  dependencies: [
    .package(
      url: "https://github.com/plx/HDXLCommonUtilities",
      from: "0.0.0"
    ),
    .package(
      url: "https://github.com/plx/HDXLTestingUtilities",
      from: "0.0.0"
    )
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "HDXLAlgebraicUtilities",
      dependencies: [
        "HDXLCommonUtilities"
      ],
      exclude: [
        "Collections/Product/ProductCollections.md"
      ]
    ),
    .testTarget(
      name: "HDXLAlgebraicUtilitiesTests",
      dependencies: [
        "HDXLAlgebraicUtilities",
        "HDXLTestingUtilities",
        "HDXLCommonUtilities"
      ],
      exclude: [
        "Algebra/Product/UniformValueAccess/UVATestRemarks.markdown"
      ]
    ),
    .testTarget(
      name: "HDXLAlgebraicUtilitiesCollectionValidation",
      dependencies: [
        "HDXLAlgebraicUtilities",
        "HDXLTestingUtilities",
        "HDXLCommonUtilities"
      ]
    )
  ],
  swiftLanguageVersions: [
    SwiftVersion.v5
  ]
)

