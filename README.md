# BeforeSetup

**Note**: BeforeSetup is still under development and many things are subject to change.

## Getting Started

### Supported Platforms

macOS

### Installation

You can use `BeforeSetup` as a command line tool that you run manually, or as part of some other toolchain. Currently you have to install `BeforeSetup` manually. You can download the binary file here, and copy it to `/usr/local/bin/`.

### Usage

You need to create a [GitHub Personal Access Token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) with `repo` permission, which will allow `BeforeSetup` to access your repositories.

Then you need to have a configurations file stored somewhere on your computer following [the YAML standard](http://yaml.org). For example:

```yaml
labels:
  - name: bug
    color: d73a4a
  - name: good first issue
    color: 7057ff
protectedBranches:
  - hasDismissableStaleReviews: true
    hasRequiredReviews: true
    hasRequiredStatusChecks: true
    hasRestrictedPushes: true
    hasRestrictedReviewDismissals: true
    hasStrictRequiredStatusChecks: true
    isAdminEnforced: false
    name: master
    requiredStatusCheckContexts: []
repositoryTopics:
  - topic:
      name: github
  - topic:
      name: configuration-management
codeOfConduct:
  name: Contributor Covenant
description: Validate Your GitHub Repository Settings
hasIssuesEnabled: true
hasWikiEnabled: false
homepageUrl: http://www.tintpoint.com
isArchived: false
isPrivate: false
licenseInfo:
  name: MIT License
name: BeforeSetup
url: https://github.com/TintPoint/BeforeSetup
```

Then you can run just type:

```bash
> beforesetup --token <GitHubToken> --repo <Owner>/<Name> --config <FilePath>
```

If you have any question, just type:

```bash
> beforesetup --help
```

## Development

### Requirements

Swift 4+

### Setup Dependencies

Make sure you have the latest version of [Xcode](https://developer.apple.com/xcode/) and [Yarn](https://yarnpkg.com) installed.

```bash
> yarn global add apollo-codegen
> apollo-codegen introspect-schema "https://api.github.com/graphql" --header "Authorization: Bearer <token>"
> apollo-codegen generate **.graphql --output "Sources/BeforeSetup/GraphQL/API.swift"
```
