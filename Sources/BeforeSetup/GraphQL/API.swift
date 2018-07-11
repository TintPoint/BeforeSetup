//  This file was automatically generated and should not be edited.

import Apollo

public final class RepositoryQuery: GraphQLQuery {
  public let operationDefinition =
    "query Repository($name: String!, $owner: String!) {\n  repository(name: $name, owner: $owner) {\n    __typename\n    labels(first: 10) {\n      __typename\n      nodes {\n        __typename\n        color\n        description\n        isDefault\n        name\n      }\n      totalCount\n    }\n    protectedBranches(first: 10) {\n      __typename\n      nodes {\n        __typename\n        hasDismissableStaleReviews\n        hasRequiredReviews\n        hasRequiredStatusChecks\n        hasRestrictedPushes\n        hasRestrictedReviewDismissals\n        hasStrictRequiredStatusChecks\n        isAdminEnforced\n        name\n        requiredStatusCheckContexts\n      }\n      totalCount\n    }\n    repositoryTopics(first: 10) {\n      __typename\n      nodes {\n        __typename\n        topic {\n          __typename\n          name\n        }\n      }\n      totalCount\n    }\n    codeOfConduct {\n      __typename\n      name\n    }\n    description\n    hasIssuesEnabled\n    hasWikiEnabled\n    homepageUrl\n    id\n    isArchived\n    isPrivate\n    licenseInfo {\n      __typename\n      name\n    }\n    mergeCommitAllowed\n    name\n    rebaseMergeAllowed\n    squashMergeAllowed\n    url\n  }\n}"

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

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
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

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(labels: Label? = nil, protectedBranches: ProtectedBranch, repositoryTopics: RepositoryTopic, codeOfConduct: CodeOfConduct? = nil, description: String? = nil, hasIssuesEnabled: Bool, hasWikiEnabled: Bool, homepageUrl: String? = nil, id: GraphQLID, isArchived: Bool, isPrivate: Bool, licenseInfo: LicenseInfo? = nil, mergeCommitAllowed: Bool, name: String, rebaseMergeAllowed: Bool, squashMergeAllowed: Bool, url: String) {
        self.init(unsafeResultMap: ["__typename": "Repository", "labels": labels.flatMap { (value: Label) -> ResultMap in value.resultMap }, "protectedBranches": protectedBranches.resultMap, "repositoryTopics": repositoryTopics.resultMap, "codeOfConduct": codeOfConduct.flatMap { (value: CodeOfConduct) -> ResultMap in value.resultMap }, "description": description, "hasIssuesEnabled": hasIssuesEnabled, "hasWikiEnabled": hasWikiEnabled, "homepageUrl": homepageUrl, "id": id, "isArchived": isArchived, "isPrivate": isPrivate, "licenseInfo": licenseInfo.flatMap { (value: LicenseInfo) -> ResultMap in value.resultMap }, "mergeCommitAllowed": mergeCommitAllowed, "name": name, "rebaseMergeAllowed": rebaseMergeAllowed, "squashMergeAllowed": squashMergeAllowed, "url": url])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of labels associated with the repository.
      public var labels: Label? {
        get {
          return (resultMap["labels"] as? ResultMap).flatMap { Label(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "labels")
        }
      }

      /// A list of protected branches that are on this repository.
      public var protectedBranches: ProtectedBranch {
        get {
          return ProtectedBranch(unsafeResultMap: resultMap["protectedBranches"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "protectedBranches")
        }
      }

      /// A list of applied repository-topic associations for this repository.
      public var repositoryTopics: RepositoryTopic {
        get {
          return RepositoryTopic(unsafeResultMap: resultMap["repositoryTopics"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "repositoryTopics")
        }
      }

      /// Returns the code of conduct for this repository
      public var codeOfConduct: CodeOfConduct? {
        get {
          return (resultMap["codeOfConduct"] as? ResultMap).flatMap { CodeOfConduct(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "codeOfConduct")
        }
      }

      /// The description of the repository.
      public var description: String? {
        get {
          return resultMap["description"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      /// Indicates if the repository has issues feature enabled.
      public var hasIssuesEnabled: Bool {
        get {
          return resultMap["hasIssuesEnabled"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasIssuesEnabled")
        }
      }

      /// Indicates if the repository has wiki feature enabled.
      public var hasWikiEnabled: Bool {
        get {
          return resultMap["hasWikiEnabled"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "hasWikiEnabled")
        }
      }

      /// The repository's URL.
      public var homepageUrl: String? {
        get {
          return resultMap["homepageUrl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "homepageUrl")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// Indicates if the repository is unmaintained.
      public var isArchived: Bool {
        get {
          return resultMap["isArchived"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isArchived")
        }
      }

      /// Identifies if the repository is private.
      public var isPrivate: Bool {
        get {
          return resultMap["isPrivate"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isPrivate")
        }
      }

      /// The license associated with the repository
      public var licenseInfo: LicenseInfo? {
        get {
          return (resultMap["licenseInfo"] as? ResultMap).flatMap { LicenseInfo(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "licenseInfo")
        }
      }

      /// Whether or not PRs are merged with a merge commit on this repository.
      public var mergeCommitAllowed: Bool {
        get {
          return resultMap["mergeCommitAllowed"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "mergeCommitAllowed")
        }
      }

      /// The name of the repository.
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Whether or not rebase-merging is enabled on this repository.
      public var rebaseMergeAllowed: Bool {
        get {
          return resultMap["rebaseMergeAllowed"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "rebaseMergeAllowed")
        }
      }

      /// Whether or not squash-merging is enabled on this repository.
      public var squashMergeAllowed: Bool {
        get {
          return resultMap["squashMergeAllowed"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "squashMergeAllowed")
        }
      }

      /// The HTTP URL for this repository
      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      public struct Label: GraphQLSelectionSet {
        public static let possibleTypes = ["LabelConnection"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("nodes", type: .list(.object(Node.selections))),
          GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil, totalCount: Int) {
          self.init(unsafeResultMap: ["__typename": "LabelConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["Label"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("color", type: .nonNull(.scalar(String.self))),
            GraphQLField("description", type: .scalar(String.self)),
            GraphQLField("isDefault", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(color: String, description: String? = nil, isDefault: Bool, name: String) {
            self.init(unsafeResultMap: ["__typename": "Label", "color": color, "description": description, "isDefault": isDefault, "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Identifies the label color.
          public var color: String {
            get {
              return resultMap["color"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "color")
            }
          }

          /// A brief description of this label.
          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }

          /// Indicates whether or not this is a default label.
          public var isDefault: Bool {
            get {
              return resultMap["isDefault"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isDefault")
            }
          }

          /// Identifies the label name.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
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

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil, totalCount: Int) {
          self.init(unsafeResultMap: ["__typename": "ProtectedBranchConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
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

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(hasDismissableStaleReviews: Bool, hasRequiredReviews: Bool, hasRequiredStatusChecks: Bool, hasRestrictedPushes: Bool, hasRestrictedReviewDismissals: Bool, hasStrictRequiredStatusChecks: Bool, isAdminEnforced: Bool, name: String, requiredStatusCheckContexts: [String?]? = nil) {
            self.init(unsafeResultMap: ["__typename": "ProtectedBranch", "hasDismissableStaleReviews": hasDismissableStaleReviews, "hasRequiredReviews": hasRequiredReviews, "hasRequiredStatusChecks": hasRequiredStatusChecks, "hasRestrictedPushes": hasRestrictedPushes, "hasRestrictedReviewDismissals": hasRestrictedReviewDismissals, "hasStrictRequiredStatusChecks": hasStrictRequiredStatusChecks, "isAdminEnforced": isAdminEnforced, "name": name, "requiredStatusCheckContexts": requiredStatusCheckContexts])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// Will new commits pushed to this branch dismiss pull request review approvals.
          public var hasDismissableStaleReviews: Bool {
            get {
              return resultMap["hasDismissableStaleReviews"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasDismissableStaleReviews")
            }
          }

          /// Are reviews required to update this branch.
          public var hasRequiredReviews: Bool {
            get {
              return resultMap["hasRequiredReviews"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasRequiredReviews")
            }
          }

          /// Are status checks required to update this branch.
          public var hasRequiredStatusChecks: Bool {
            get {
              return resultMap["hasRequiredStatusChecks"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasRequiredStatusChecks")
            }
          }

          /// Is pushing to this branch restricted.
          public var hasRestrictedPushes: Bool {
            get {
              return resultMap["hasRestrictedPushes"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasRestrictedPushes")
            }
          }

          /// Is dismissal of pull request reviews restricted.
          public var hasRestrictedReviewDismissals: Bool {
            get {
              return resultMap["hasRestrictedReviewDismissals"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasRestrictedReviewDismissals")
            }
          }

          /// Are branches required to be up to date before merging.
          public var hasStrictRequiredStatusChecks: Bool {
            get {
              return resultMap["hasStrictRequiredStatusChecks"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "hasStrictRequiredStatusChecks")
            }
          }

          /// Can admins overwrite branch protection.
          public var isAdminEnforced: Bool {
            get {
              return resultMap["isAdminEnforced"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "isAdminEnforced")
            }
          }

          /// Identifies the name of the protected branch.
          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// List of required status check contexts that must pass for commits to be accepted to this branch.
          public var requiredStatusCheckContexts: [String?]? {
            get {
              return resultMap["requiredStatusCheckContexts"] as? [String?]
            }
            set {
              resultMap.updateValue(newValue, forKey: "requiredStatusCheckContexts")
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

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil, totalCount: Int) {
          self.init(unsafeResultMap: ["__typename": "RepositoryTopicConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, "totalCount": totalCount])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes.
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        /// Identifies the total count of items in the connection.
        public var totalCount: Int {
          get {
            return resultMap["totalCount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "totalCount")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes = ["RepositoryTopic"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("topic", type: .nonNull(.object(Topic.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(topic: Topic) {
            self.init(unsafeResultMap: ["__typename": "RepositoryTopic", "topic": topic.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The topic.
          public var topic: Topic {
            get {
              return Topic(unsafeResultMap: resultMap["topic"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "topic")
            }
          }

          public struct Topic: GraphQLSelectionSet {
            public static let possibleTypes = ["Topic"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String) {
              self.init(unsafeResultMap: ["__typename": "Topic", "name": name])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// The topic's name.
            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
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

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "CodeOfConduct", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The formal name of the CoC
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct LicenseInfo: GraphQLSelectionSet {
        public static let possibleTypes = ["License"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String) {
          self.init(unsafeResultMap: ["__typename": "License", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The license full name specified by <https://spdx.org/licenses>
        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}