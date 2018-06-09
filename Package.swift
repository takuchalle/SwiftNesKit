// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftNesKit",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SwiftNesKit",
            targets: ["SwiftNesKit"]),
        .executable(name: "nes-disasm", targets: ["SwiftNesDisassemble"]),
        .executable(name: "nes-cpu", targets: ["SwiftNesCpu"]),
    ],
    dependencies: [
      .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftNesKit",
            dependencies: []),
        .target(
            name: "SwiftNesDisassemble",
            dependencies: ["SwiftNesKit", "Commander"]),
        .target(
            name: "SwiftNesCpu",
            dependencies: ["SwiftNesKit", "Commander"]),
        .testTarget(
            name: "SwiftNesTests",
            dependencies: ["SwiftNesKit"]),
    ]
)
