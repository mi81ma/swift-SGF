# SGF

Parser and utility functions for Smart Game Format in Swift

The parser is generated by [Citron](http://roopc.net/citron/).

## Usage

Add dependencies in Package.swift:
```swift
let package = Package(
    name: "your-project",
    dependencies: [
        ...
        .package(url: "https://github.com/y-ich/swift-DDP.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "your-project",
            dependencies: [..., "SGF"]),
    ]
)
```

### exmaples

See test code.

## TODO

- Charset(CA) support

## License

MIT, except for CitronLexer.swift and CitronParser.swift.
For CitronLexer.swift and CitronParser.swift, see file headers.
