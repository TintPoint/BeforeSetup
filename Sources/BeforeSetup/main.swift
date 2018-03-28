import Foundation
import Apollo

let beforeSetupVersion = "0.2"

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

    func checkRepository(name: String, owner: String, configurations: Configurations) -> Int {
        let query = RepositoryQuery(name: name, owner: owner)
        let group = DispatchGroup()
        var mismatchCount = 0
        client.fetch(query: query, queue: .global(qos: .userInitiated)) { result, error in
            defer { group.leave() }
            do {
                if let error = error { throw error }
                guard let result = result else { throw NetworkError.emptyQueryResult }
                if let errors = result.errors { throw NetworkError.graphQLErrors(errors) }
                guard let data = result.data, let repository = data.repository else { throw NetworkError.emptyQueryResult }
                mismatchCount = Checker(expect: repository, equals: configurations.repository).validate()
            } catch {
                Terminal.output(error.localizedDescription, to: .standardError, color: .red)
            }
        }
        group.enter()
        group.wait()
        return mismatchCount
    }
}

do {
    let arguments = try Terminal(processInfo: .processInfo).arguments
    guard let token = arguments.githubToken else { throw GeneralError.missingToken }
    guard arguments.repositories.isEmpty == false else { throw GeneralError.missingRepository }
    let beforeSetup = try BeforeSetup(token: token)
    var totalMismatchCount = 0, totalPassedRepositoryCount = 0, totalFailedRepositoryCount = 0
    for (owner, name, configurationsURL) in arguments.repositories {
        let configurationsURL = configurationsURL ?? arguments.defaultConfigurationsURL
        let configurations = try Configurations(fileURL: configurationsURL)
        let mismatchCount = beforeSetup.checkRepository(name: name, owner: owner, configurations: configurations)
        totalMismatchCount += mismatchCount
        switch mismatchCount {
        case 0:
            totalPassedRepositoryCount += 1
            Terminal.output(configurationsURL.absoluteString)
            Terminal.output("\(owner)/\(name) passed all checks.\n", color: .green)
        default:
            totalFailedRepositoryCount += 1
            Terminal.output(configurationsURL.absoluteString)
            Terminal.output("\(owner)/\(name) has \(mismatchCount) mismatches.\n", color: .red)
        }
    }
    switch totalMismatchCount {
    case 0:
        Terminal.output("Congratulations! All \(totalPassedRepositoryCount) repositories passed all checks.", color: .green)
    default:
        Terminal.output("\(totalPassedRepositoryCount) repositories passed all checks while \(totalFailedRepositoryCount) repositories failed with total \(totalMismatchCount) mismatches.", color: .red)
    }
} catch {
    Terminal.output(error.localizedDescription, to: .standardError, color: .red)
}
