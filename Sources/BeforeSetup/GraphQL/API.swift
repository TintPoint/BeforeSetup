//  This file was automatically generated and should not be edited.

import Apollo

public final class RepositoryQuery: GraphQLQuery {
  public static let operationString =
    "query Repository($name: String!, $owner: String!) {\n  repository(name: $name, owner: $owner) {\n    __typename\n    labels(first: 10) {\n      __typename\n      nodes {\n        __typename\n        color\n        name\n      }\n      totalCount\n    }\n    protectedBranches(first: 10) {\n      __typename\n      nodes {\n        __typename\n        hasDismissableStaleReviews\n        hasRequiredReviews\n        hasRequiredStatusChecks\n        hasRestrictedPushes\n        hasRestrictedReviewDismissals\n        hasStrictRequiredStatusChecks\n        isAdminEnforced\n        name\n        requiredStatusCheckContexts\n      }\n      totalCount\n    }\n    repositoryTopics(first: 10) {\n      __typename\n      nodes {\n        __typename\n        topic {\n          __typename\n          name\n        }\n      }\n      totalCount\n    }\n    codeOfConduct {\n      __typename\n      name\n    }\n    description\n    hasIssuesEnabled\n    hasWikiEnabled\n    homepageUrl\n    id\n    isArchived\n    isPrivate\n    licenseInfo {\n      __typename\n      name\n    }\n    mergeCommitAllowed\n    name\n    rebaseMergeAllowed\n    squashMergeAllowed\n    url\n  }\n}"

  public var name: String
  public var owner: String

  public init(name: String, owner: String) {
    self.name = name
    self.owner = owner
  }

  public var variables: GraphQLMap? {
    return ["name": name, "owner": owner]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["name": GraphQLVariable("name"), "owner": GraphQLVariable("owner")], type: .object(Repository.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(repository: Repository? = nil) {
      self.init(snapshot: ["__typename": "Query", "repository": repository.flatMap { $0.snapshot }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (snapshot["repository"] as? Snapshot).flatMap { Repository(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("labels", arguments: ["first": 10], type: .object(Label.selections)),
        GraphQLField("protectedBranches", arguments: ["first": 10], type: .nonNull(.object(ProtectedBranch.selections))),
        GraphQLField("repositoryTopics", arguments: ["first": 10], type: .nonNull(.object(RepositoryTopic.selections))),
        GraphQLField("codeOfConduct", type: .object(CodeOfConduct.selections)),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("hasIssuesEnabled", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("hasWikiEnabled", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("homepageUrl", type: .scalar(String.self)),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("isArchived", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("isPrivate", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("licenseInfo", type: .object(LicenseInfo.selections)),
        GraphQLField("mergeCommitAllowed", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("rebaseMergeAllowed", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("squashMergeAllowed", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("url", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(labels: Label? = nil, protectedBranches: ProtectedBranch, repositoryTopics: RepositoryTopic, codeOfConduct: CodeOfConduct? = nil, description: String? = nil, hasIssuesEnabled: Bool, hasWikiEnabled: Bool, homepageUrl: String? = nil, id: GraphQLID, isArchived: Bool, isPrivate: Bool, licenseInfo: LicenseInfo? = nil, mergeCommitAllowed: Bool, name: String, rebaseMergeAllowed: Bool, squashMergeAllowed: Bool, url: String) {
        self.init(snapshot: ["__typename": "Repository", "labels": labels.flatMap { $0.snapshot }, "protectedBranches": protectedBranches.snapshot, "repositoryTopics": repositoryTopics.snapshot, "codeOfConduct": codeOfConduct.flatMap { $0.snapshot }, "description": description, "hasIssuesEnabled": hasIssuesEnabled, "hasWikiEnabled": hasWikiEnabled, "homepageUrl": homepageUrl, "id": id, "isArchived": isArchived, "isPrivate": isPrivate, "licenseInfo": licenseInfo.flatMap { $0.snapshot }, "mergeCommitAllowed": mergeCommitAllowed, "name": name, "rebaseMergeAllowed": rebaseMergeAllowed, "squashMergeAllowed": squashMergeAllowed, "url": url])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of labels associated with the repository.
      public var labels: Label? {
        get {
          return (snapshot["labels"] as? Snapshot).flatMap { Label(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "labels")
        }
      }

      /// A list of protected branches that are on this repository.
      public var protectedBranches: ProtectedBranch {
        get {
          return ProtectedBranch(snapshot: snapshot["protectedBranches"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "protectedBranches")
        }
      }

      /// A list of applied repository-topic associations for this repository.
      public var repositoryTopics: RepositoryTopic {
        get {
          return RepositoryTopic(snapshot: snapshot["repositoryTopics"]! as! Snapshot)
        }
        set {
          snapshot.updateValue(newValue.snapshot, forKey: "repositoryTopics")
        }
      }

      /// Returns the code of conduct for this repository
      public var codeOfConduct: CodeOfConduct? {
        get {
          return (snapshot["codeOfConduct"] as? Snapshot).flatMap { CodeOfConduct(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "codeOfConduct")
        }
      }

      /// The description of the repository.
      public var description: String? {
        get {
          return snapshot["description"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "description")
        }
      }

      /// Indicates if the repository has issues feature enabled.
      public var hasIssuesEnabled: Bool {
        get {
          return snapshot["hasIssuesEnabled"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "hasIssuesEnabled")
        }
      }

      /// Indicates if the repository has wiki feature enabled.
      public var hasWikiEnabled: Bool {
        get {
          return snapshot["hasWikiEnabled"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "hasWikiEnabled")
        }
      }

      /// The repository's URL.
      public var homepageUrl: String? {
        get {
          return snapshot["homepageUrl"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "homepageUrl")
        }
      }

      public var id: GraphQLID {
        get {
          return snapshot["id"]! as! GraphQLID
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// Indicates if the repository is unmaintained.
      public var isArchived: Bool {
        get {
          return snapshot["isArchived"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isArchived")
        }
      }

      /// Identifies if the repository is private.
      public var isPrivate: Bool {
        get {
          return snapshot["isPrivate"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "isPrivate")
        }
      }

      /// The license associated with the repository
      public var licenseInfo: LicenseInfo? {
        get {
          return (snapshot["licenseInfo"] as? Snapshot).flatMap { LicenseInfo(snapshot: $0) }
        }
        set {
          snapshot.updateValue(newValue?.snapshot, forKey: "licenseInfo")
        }
      }

      /// Whether or not PRs are merged with a merge commit on this repository.
      public var mergeCommitAllowed: Bool {
        get {
          return snapshot["mergeCommitAllowed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "mergeCommitAllowed")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return snapshot["name"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "name")
        }
      }

      /// Whether or not rebase-merging is enabled on this repository.
      public var rebaseMergeAllowed: Bool {
        get {
          return snapshot["rebaseMergeAllowed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "rebaseMergeAllowed")
        }
      }

      /// Whether or not squash-merging is enabled on this repository.
      public var squashMergeAllowed: Bool {
        get {
          return snapshot["squashMergeAllowed"]! as! Bool
        }
        set {
          snapshot.updateValue(newValue, forKey: "squashMergeAllowed")
        }
      }

      /// The HTTP URL for this repository
      public var url: String {
        get {
          return snapshot["url"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "url")
        }
      }

      public struct Label: GraphQLSelectionSet {
        public static let possibleTypes = ["LabelConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
          GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil, totalCount: Int) {
          self.init(snapshot: ["__typename": "LabelConnection", "nodes": nodes.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (snapshot["nodes"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return snapshot["totalCount"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "totalCount")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Label"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("color", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(color: String, name: String) {
            self.init(snapshot: ["__typename": "Label", "color": color, "name": name])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the label color.
          public var color: String {
            get {
              return snapshot["color"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "color")
            }
          }

          /// Identifies the label name.
          public var name: String {
            get {
              return snapshot["name"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct ProtectedBranch: GraphQLSelectionSet {
        public static let possibleTypes = ["ProtectedBranchConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
          GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil, totalCount: Int) {
          self.init(snapshot: ["__typename": "ProtectedBranchConnection", "nodes": nodes.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (snapshot["nodes"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return snapshot["totalCount"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "totalCount")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["ProtectedBranch"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("hasDismissableStaleReviews", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("hasRequiredReviews", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("hasRequiredStatusChecks", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("hasRestrictedPushes", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("hasRestrictedReviewDismissals", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("hasStrictRequiredStatusChecks", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("isAdminEnforced", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("requiredStatusCheckContexts", type: .list(.scalar(String.self))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(hasDismissableStaleReviews: Bool, hasRequiredReviews: Bool, hasRequiredStatusChecks: Bool, hasRestrictedPushes: Bool, hasRestrictedReviewDismissals: Bool, hasStrictRequiredStatusChecks: Bool, isAdminEnforced: Bool, name: String, requiredStatusCheckContexts: [String?]? = nil) {
            self.init(snapshot: ["__typename": "ProtectedBranch", "hasDismissableStaleReviews": hasDismissableStaleReviews, "hasRequiredReviews": hasRequiredReviews, "hasRequiredStatusChecks": hasRequiredStatusChecks, "hasRestrictedPushes": hasRestrictedPushes, "hasRestrictedReviewDismissals": hasRestrictedReviewDismissals, "hasStrictRequiredStatusChecks": hasStrictRequiredStatusChecks, "isAdminEnforced": isAdminEnforced, "name": name, "requiredStatusCheckContexts": requiredStatusCheckContexts])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Will new commits pushed to this branch dismiss pull request review approvals.
          public var hasDismissableStaleReviews: Bool {
            get {
              return snapshot["hasDismissableStaleReviews"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasDismissableStaleReviews")
            }
          }

          /// Are reviews required to update this branch.
          public var hasRequiredReviews: Bool {
            get {
              return snapshot["hasRequiredReviews"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasRequiredReviews")
            }
          }

          /// Are status checks required to update this branch.
          public var hasRequiredStatusChecks: Bool {
            get {
              return snapshot["hasRequiredStatusChecks"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasRequiredStatusChecks")
            }
          }

          /// Is pushing to this branch restricted.
          public var hasRestrictedPushes: Bool {
            get {
              return snapshot["hasRestrictedPushes"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasRestrictedPushes")
            }
          }

          /// Is dismissal of pull request reviews restricted.
          public var hasRestrictedReviewDismissals: Bool {
            get {
              return snapshot["hasRestrictedReviewDismissals"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasRestrictedReviewDismissals")
            }
          }

          /// Are branches required to be up to date before merging.
          public var hasStrictRequiredStatusChecks: Bool {
            get {
              return snapshot["hasStrictRequiredStatusChecks"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "hasStrictRequiredStatusChecks")
            }
          }

          /// Can admins overwrite branch protection.
          public var isAdminEnforced: Bool {
            get {
              return snapshot["isAdminEnforced"]! as! Bool
            }
            set {
              snapshot.updateValue(newValue, forKey: "isAdminEnforced")
            }
          }

          /// Identifies the name of the protected branch.
          public var name: String {
            get {
              return snapshot["name"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }

          /// List of required status check contexts that must pass for commits to be accepted to this branch.
          public var requiredStatusCheckContexts: [String?]? {
            get {
              return snapshot["requiredStatusCheckContexts"] as? [String?]
            }
            set {
              snapshot.updateValue(newValue, forKey: "requiredStatusCheckContexts")
            }
          }
        }
      }

      public struct RepositoryTopic: GraphQLSelectionSet {
        public static let possibleTypes = ["RepositoryTopicConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
          GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(nodes: [Node?]? = nil, totalCount: Int) {
          self.init(snapshot: ["__typename": "RepositoryTopicConnection", "nodes": nodes.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (snapshot["nodes"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
          }
          set {
            snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return snapshot["totalCount"]! as! Int
          }
          set {
            snapshot.updateValue(newValue, forKey: "totalCount")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["RepositoryTopic"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("topic", type: .nonNull(.object(Topic.selections))),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(topic: Topic) {
            self.init(snapshot: ["__typename": "RepositoryTopic", "topic": topic.snapshot])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The topic.
          public var topic: Topic {
            get {
              return Topic(snapshot: snapshot["topic"]! as! Snapshot)
            }
            set {
              snapshot.updateValue(newValue.snapshot, forKey: "topic")
            }
          }

          public struct Topic: GraphQLSelectionSet {
            public static let possibleTypes = ["Topic"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public var snapshot: Snapshot

            public init(snapshot: Snapshot) {
              self.snapshot = snapshot
            }

            public init(name: String) {
              self.init(snapshot: ["__typename": "Topic", "name": name])
            }

            public var __typename: String {
              get {
                return snapshot["__typename"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The topic's name.
            public var name: String {
              get {
                return snapshot["name"]! as! String
              }
              set {
                snapshot.updateValue(newValue, forKey: "name")
              }
            }
          }
        }
      }

      public struct CodeOfConduct: GraphQLSelectionSet {
        public static let possibleTypes = ["CodeOfConduct"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String) {
          self.init(snapshot: ["__typename": "CodeOfConduct", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The formal name of the CoC
        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct LicenseInfo: GraphQLSelectionSet {
        public static let possibleTypes = ["License"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public init(name: String) {
          self.init(snapshot: ["__typename": "License", "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The license full name specified by <https://spdx.org/licenses>
        public var name: String {
          get {
            return snapshot["name"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}