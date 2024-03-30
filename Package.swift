// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwappableDependencies",
	platforms: [
		.iOS(.v15),
		.macOS(.v10_15)
	],
  products: [
    .library(
      name: "SwappableDependencies",
      targets: ["SwappableDependencies"]
    )
  ],
	dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.2.2"),
		.package(url: "https://github.com/groue/GRDB.swift", from: "6.22.0")
	],
  targets: [
		.target(
			name: "SwappableDependencies",
			dependencies: [
				.product(name: "GRDB", package: "GRDB.swift"),
				.product(name: "Dependencies", package: "swift-dependencies"),
				.product(name: "DependenciesMacros", package: "swift-dependencies"),
			]
		)
  ]
)
