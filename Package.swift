// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package =
    Package(
    name: "charon",
    platforms: [
        .macOS(.v10_13), .iOS(.v11)
    ],
    products: [
        .executable(name: "charon",
                    targets: ["charon"]),
        .executable(name: "xortool",
                    targets: ["xortool"]),
        .library(name: "plugin",
                 type: .dynamic,
                 targets: ["plugin"])
    ],
    dependencies: [
    ],
    targets: [

        .target(
            name: "charon",
            dependencies: [],
            exclude: ["Sources/SamplePlugin"],
            linkerSettings: [
                .unsafeFlags([
                                "-Xlinker", "-sectcreate",
                                "-Xlinker", "__TEXT",
                                "-Xlinker", "__charon",
                                "-Xlinker", ".build/debug/libplugin.dylib"
                ])
            ]),
        .target(
            name: "xortool",
            dependencies: [],
            path: "Sources/xortool",
            exclude: ["Sources/charon"]),
        .target(
            name: "plugin",
            dependencies: [],
            path: "Sources/SamplePlugin",
            exclude: ["Sources/charon"]),

    ]
)
