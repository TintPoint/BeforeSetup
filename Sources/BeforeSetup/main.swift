import Foundation
import Apollo

let beforeSetupVersion = "0.1"

class BeforeSetup {
    private let configuration: URLSessionConfiguration
    private let client: ApolloClient
    private let urlString: String

    init(token: String) throws {
        configuration = .default
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        urlString = "https://api.github.com/graphql"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidBaseURLString(urlString) }
        client = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }

    func checkRepository(name: String, owner: String, configurations: Configurations) {
        Terminal.output("\(owner)/\(name)", color: .green)
        let query = RepositoryQuery(name: name, owner: owner)
        let group = DispatchGroup()
        client.fetch(query: query, queue: .global(qos: .userInitiated)) { result, error in
            defer { group.leave() }
            do {
                if let error = error { throw error }
                guard let result = result else { throw NetworkError.emptyQueryResult }
                if let errors = result.errors { throw NetworkError.graphQLErrors(errors) }
                guard let data = result.data, let repository = data.repository else { throw NetworkError.emptyQueryResult }
                Checker(expect: repository, equals: configurations.repository).validate()
            } catch {
                Terminal.output(error.localizedDescription, to: .standardError, color: .red)
            }
        }
        group.enter()
        group.wait()
    }
}

do {
    let arguments = try Terminal(processInfo: .processInfo).arguments
    guard let token = arguments.githubToken else { throw GeneralError.missingToken }
    let beforeSetup = try BeforeSetup(token: token)
    let configurations = try Configurations(fileURL: arguments.configurationsURL)
    guard let owner = arguments.repositoryOwner else { throw GeneralError.missingRepositoryOwner }
    guard let name = arguments.repositoryName else { throw GeneralError.missingRepositoryName }
    beforeSetup.checkRepository(name: name, owner: owner, configurations: configurations)
} catch {
    Terminal.output(error.localizedDescription, to: .standardError, color: .red)
}
