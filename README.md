# BeforeSetup

**Note**: BeforeSetup is still under development and many things are subject to change.

## Requirements

Swift 4+

## Getting Started

```bash
> git clone https://github.com/TintPoint/BeforeSetup.git
> cd BeforeSetup
> swift build
> swift run
```

## Development

### Setup Dependencies

Make sure you have the latest version of [Xcode](https://developer.apple.com/xcode/) and [Yarn](https://yarnpkg.com) installed.

```bash
> yarn global add apollo-codegen
> apollo-codegen introspect-schema "https://api.github.com/graphql" --header "Authorization: Bearer <token>"
> apollo-codegen generate **.graphql --output "Sources/BeforeSetup/GraphQL/API.swift"
```

### Release Command Line Tool

```bash
> swift build -c release -Xswiftc -static-stdlib
> cp -f .build/release/beforesetup /usr/local/bin/beforesetup
```
