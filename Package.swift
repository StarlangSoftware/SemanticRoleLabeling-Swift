// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SemanticRoleLabeling",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SemanticRoleLabeling",
            targets: ["SemanticRoleLabeling"]),
    ],
    dependencies: [
        .package(name: "AnnotatedTree", url: "https://github.com/StarlangSoftware/AnnotatedTree-Swift.git", .exact("1.0.5")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SemanticRoleLabeling",
            dependencies: ["AnnotatedTree"]),
        .testTarget(
            name: "SemanticRoleLabelingTests",
            dependencies: ["SemanticRoleLabeling"]),
    ]
)
