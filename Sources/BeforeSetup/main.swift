import Foundation
import Apollo

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
                Terminal.output(error.localizedDescription, to: .standardError)
            }
        }
        group.enter()
        group.wait()
    }
}

do {
    guard let token = ProcessInfo.processInfo.environment["BEFORE_SETUP_TOKEN"] else { throw GeneralError.missingToken }
    let configurationsURLString = ".beforesetup.yaml"
    let configurations = try Configurations(fileURL: URL(fileURLWithPath: configurationsURLString))
    let beforeSetup = try BeforeSetup(token: token)
    beforeSetup.checkRepository(name: "BeforeSetup", owner: "TintPoint", configurations: configurations)
    beforeSetup.checkRepository(name: "Overlay", owner: "TintPoint", configurations: configurations)
} catch {
    Terminal.output(error.localizedDescription, to: .standardError)
}
