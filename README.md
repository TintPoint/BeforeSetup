# BeforeSetup

**Note**: BeforeSetup is still under development and many things are subject to change.

## Requirements

Swift 4+

## Getting Started

For configurations file example, please checkout `.beforesetup.yaml`.

```bash
> git clone https://github.com/TintPoint/BeforeSetup.git
> cd BeforeSetup
> bin/BeforeSetup --help
```

## Development

### Setup Dependencies

Make sure you have the latest version of [Xcode](https://developer.apple.com/xcode/) and [Yarn](https://yarnpkg.com) installed.

```bash
> yarn global add apollo-codegen
> apollo-codegen introspect-schema "https://api.github.com/graphql" --header "Authorization: Bearer <token>"
> apollo-codegen generate **.graphql --output "Sources/BeforeSetup/GraphQL/API.swift"
```
