import Foundation
import Apollo

let beforeSetupVersion = "0.1"

class BeforeSetup {
    private let configuration: URLSessionConfiguration
    private let client: ApolloClient
    private let urlString: String

    static var directoryURL: URL {
        if #available(macOS 10.12, *) {
            return FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".beforesetup", isDirectory: true)
        } else {
            return URL(fileURLWithPath: "~/.beforesetup", isDirectory: true)
        }
    }

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

extension URL {
    var isDirectory: Bool {
        if #available(macOS 10.11, *) {
            return hasDirectoryPath
        } else {
            return (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory ?? false
        }
    }

    var isFile: Bool {
        return !isDirectory
    }
}

do {
    let arguments = try Terminal(processInfo: .processInfo).arguments
    guard let token = arguments.githubToken else { throw GeneralError.missingToken }
    let beforeSetup = try BeforeSetup(token: token)
    let directoryURL = BeforeSetup.directoryURL
    if FileManager.default.fileExists(atPath: directoryURL.path) && (arguments.repositoryOwner == nil || arguments.repositoryName == nil) {
        var totalMismatchCount = 0
        var totalRepositoryCount = 0
        let ownerDirectories = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        for ownerURL in ownerDirectories where ownerURL.isDirectory {
            let owner = ownerURL.lastPathComponent
            let files = try FileManager.default.contentsOfDirectory(at: ownerURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for fileURL in files where fileURL.isFile {
                let name = fileURL.deletingPathExtension().lastPathComponent
                let configurations = try Configurations(fileURL: fileURL)
                let mismatchCount = beforeSetup.checkRepository(name: name, owner: owner, configurations: configurations)
                totalMismatchCount += mismatchCount
                totalRepositoryCount += 1
                switch mismatchCount {
                case 0: Terminal.output("\(owner)/\(name) tests are passed.\n", color: .green)
                default: Terminal.output("\(owner)/\(name) has \(mismatchCount) mismatches.\n", color: .red)
                }
            }
        }
        switch totalMismatchCount {
        case 0: Terminal.output("Congratulations! All \(totalRepositoryCount) repositories are passed.\n", color: .green)
        default: Terminal.output("You have total \(totalMismatchCount) mismatches.\n", color: .red)
        }
    } else {
        guard let owner = arguments.repositoryOwner else { throw GeneralError.missingRepositoryOwner }
        guard let name = arguments.repositoryName else { throw GeneralError.missingRepositoryName }
        let configurations = try Configurations(fileURL: arguments.configurationsURL)
        switch beforeSetup.checkRepository(name: name, owner: owner, configurations: configurations) {
        case 0: Terminal.output("Congratulations! \(owner)/\(name) tests are passed.\n", color: .green)
        case let mismatchCount: Terminal.output("\(owner)/\(name) has \(mismatchCount) mismatches.\n", color: .red)
        }
    }
} catch {
    Terminal.output(error.localizedDescription, to: .standardError, color: .red)
}
