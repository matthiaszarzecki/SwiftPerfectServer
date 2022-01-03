// swift-tools-version:4.2

import PackageDescription

let package = Package(
  name: "MyAwesomeProject",
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "MyAwesomeProject",
      dependencies: ["PerfectHTTPServer"]
    )
  ]
)


/*
let package = Package(
	name: "PerfectTemplate",
	products: [
		.executable(name: "PerfectTemplate", targets: ["PerfectTemplate"])
	],
	dependencies: [
		.package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
	],
	targets: [
		.target(name: "PerfectTemplate", dependencies: ["PerfectHTTPServer"])
	]
)
*/
