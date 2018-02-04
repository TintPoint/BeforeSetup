import Foundation
import Apollo

enum NetworkError: Error {
    case invalidBaseURLString(String)
    case emptyQueryResult
    case graphQLErrors([GraphQLError])
}



func check<Element: Equatable & CustomStringConvertible>(_ key: String, if currentValue: Element?, is expectedValue: Element?) {
    switch (currentValue, expectedValue) {
    case (nil, nil):
        print("\(key): skipped.")
    case (let currentValue?, let expectedValue?) where currentValue == expectedValue:
        print("\(key): \(currentValue)")
    default:
        print("Warning: \(key) should be \(expectedValue?.description ?? "nil") but currently is \(currentValue?.description ?? "nil").")
    }
}

func validateRepository(_ repository: RepositoryQuery.Data.Repository) {
    check("number of labels", if: repository.labels?.totalCount ?? 0, is: 5)
    check("number of protected branches", if: repository.protectedBranches.totalCount, is: 1)
    check("number of repository topics", if: repository.repositoryTopics.totalCount, is: 6)
    check("code of conduct", if: repository.codeOfConduct?.name, is: "Contributor Covenant")
    check("description", if: repository.description, is: "Flexible UI Framework Designed for Swift")
    check("has issues enabled", if: repository.hasIssuesEnabled, is: true)
    check("has wiki enabled", if: repository.hasWikiEnabled, is: false)
    check("homepage url", if: repository.homepageUrl, is: "http://www.tintpoint.com")
    check("is archived", if: repository.isArchived, is: false)
    check("is private", if: repository.isPrivate, is: false)
    check("license", if: repository.licenseInfo?.name, is: "MIT License")
    check("name", if: repository.name, is: "Overlay")
    check("url", if: repository.url, is: "https://github.com/TintPoint/Overlay")
}

do {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = ["Authorization": "Bearer <Token>"]
    let urlString = "https://api.github.com/graphql"
    guard let url = URL(string: urlString) else { throw NetworkError.invalidBaseURLString(urlString) }
    let client = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    let query = RepositoryQuery(name: "Overlay", owner: "TintPoint")
    let group = DispatchGroup()
    client.fetch(query: query, queue: DispatchQueue(label: "network")) { result, error in
        defer {
            group.leave()
        }
        do {
            if let error = error { throw error }
            guard let result = result else { throw NetworkError.emptyQueryResult }
            if let errors = result.errors { throw NetworkError.graphQLErrors(errors) }
            guard let data = result.data, let repository = data.repository else { throw NetworkError.emptyQueryResult }
            validateRepository(repository)
        } catch let error {
            print(error)
        }
    }
    group.enter()
    group.wait()
} catch {
    print(error)
}
