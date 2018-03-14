import Foundation
import Yams

protocol AcceptableNonliteral { }

struct Configurations {
    struct Repository: Codable {
        var labels: [Label]?
        var protectedBranches: [ProtectedBranch]?
        var repositoryTopics: [RepositoryTopic]?
        var codeOfConduct: CodeOfConduct?
        var description: String?
        var hasIssuesEnabled: Bool?
        var hasWikiEnabled: Bool?
        var homepageUrl: String?
        var isArchived: Bool?
        var isPrivate: Bool?
        var licenseInfo: LicenseInfo?
        var mergeCommitAllowed: Bool?
        var name: String?
        var rebaseMergeAllowed: Bool?
        var squashMergeAllowed: Bool?
        var url: String?
    }

    struct Label: Codable, AcceptableNonliteral {
        var color: String?
        var name: String?
    }

    struct ProtectedBranch: Codable, AcceptableNonliteral {
        var hasDismissableStaleReviews: Bool?
        var hasRequiredReviews: Bool?
        var hasRequiredStatusChecks: Bool?
        var hasRestrictedPushes: Bool?
        var hasRestrictedReviewDismissals: Bool?
        var hasStrictRequiredStatusChecks: Bool?
        var isAdminEnforced: Bool?
        var name: String?
        var requiredStatusCheckContexts: [String]?
    }

    struct RepositoryTopic: Codable, AcceptableNonliteral {
        var topic: Topic?
    }

    struct Topic: Codable, AcceptableNonliteral {
        var name: String?
    }

    struct CodeOfConduct: Codable, AcceptableNonliteral {
        var name: String?
    }

    struct LicenseInfo: Codable, AcceptableNonliteral {
        var name: String?
    }

    let repository: Repository

    init(fileURL: URL) throws {
        let configurations = try String(contentsOf: fileURL)
        repository = try YAMLDecoder().decode(Repository.self, from: configurations)
    }
}
