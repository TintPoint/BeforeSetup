import Foundation
import Apollo

enum NetworkError: Error {
    case invalidBaseURLString(String)
    case emptyQueryResult
    case graphQLErrors([GraphQLError])
}

func check<Element: Equatable & CustomStringConvertible>(_ key: String, if currentValue: Element?, is expectedValue: Element?) -> Int {
    switch (currentValue, expectedValue) {
    case (let currentValue, let expectedValue) where currentValue == expectedValue:
        print("☑ \(key): \(currentValue?.description ?? "nil")")
        return 0
    default:
        print("☒ \(key) should be \(expectedValue?.description ?? "nil") but currently is \(currentValue?.description ?? "nil")")
        return 1
    }
}

func validateRepository(_ repository: RepositoryQuery.Data.Repository) {
    var errorCount = 0
    errorCount += check("number of labels", if: repository.labels?.totalCount, is: 5)
    errorCount += check("number of protected branches", if: repository.protectedBranches.totalCount, is: 1)
    errorCount += check("number of repository topics", if: repository.repositoryTopics.totalCount, is: 6)
    errorCount += check("code of conduct", if: repository.codeOfConduct?.name, is: "Contributor Covenant")
    errorCount += check("description", if: repository.description, is: "Flexible UI Framework Designed for Swift")
    errorCount += check("has issues enabled", if: repository.hasIssuesEnabled, is: true)
    errorCount += check("has wiki enabled", if: repository.hasWikiEnabled, is: false)
    errorCount += check("homepage url", if: repository.homepageUrl, is: "http://www.tintpoint.com")
    errorCount += check("is archived", if: repository.isArchived, is: false)
    errorCount += check("is private", if: repository.isPrivate, is: false)
    errorCount += check("license", if: repository.licenseInfo?.name, is: "MIT License")
    errorCount += check("name", if: repository.name, is: "Overlay")
    errorCount += check("url", if: repository.url, is: "https://github.com/TintPoint/Overlay")
    if errorCount == 0 {
        print("☑ Congratulations! All tests are passed.")
    } else {
        print("☒ You have \(errorCount) errors.")
    }
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
