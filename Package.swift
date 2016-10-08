import PackageDescription

let package = Package(
    name: "SwiftOneSignal",
    dependencies: [
        .Package(url: "https://github.com/vapor/engine", majorVersion: 1),
        .Package(url: "https://github.com/vapor/json.git", majorVersion: 1)
    ]
)
