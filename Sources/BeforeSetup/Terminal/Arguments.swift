import Foundation
import KeychainAccess

private extension URL {
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

class ProcessedArguments {
    fileprivate(set) var defaultDirectoryURL: URL
    fileprivate(set) var defaultConfigurationsURL: URL
    fileprivate(set) var repositories: [(owner: String, name: String, configurationsURL: URL?)]
    fileprivate(set) var githubToken: String?

    init() {
        if #available(macOS 10.12, *) {
            defaultDirectoryURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".beforesetup", isDirectory: true)
        } else {
            defaultDirectoryURL = URL(fileURLWithPath: "~/.beforesetup", isDirectory: true)
        }
        defaultConfigurationsURL = URL(fileURLWithPath: ".beforesetup.yaml")
        do {
            var directoryRepositories: [(owner: String, name: String, configurationsURL: URL?)] = []
            let ownerDirectories = try FileManager.default.contentsOfDirectory(at: defaultDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for ownerURL in ownerDirectories where ownerURL.isDirectory {
                let owner = ownerURL.lastPathComponent
                let configurations = try FileManager.default.contentsOfDirectory(at: ownerURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                for configurationsURL in configurations where configurationsURL.isFile {
                    let name = configurationsURL.deletingPathExtension().lastPathComponent
                    directoryRepositories.append((owner: owner, name: name, configurationsURL: configurationsURL))
                }
            }
            repositories = directoryRepositories
        } catch {
            repositories = []
        }
        githubToken = Keychain(server: "https://github.com", protocolType: .https)["before-setup-token"]
    }
}

class SupportedArguments {
    static let withUserInput = WithUserInput()
    static let withoutUserInput = WithoutUserInput()

    // Use global variables to workaround Swift's readwrite reflection limitation
    static var processedArguments: ProcessedArguments!
    static var nextArgument: String!
    
    class WithUserInput {
        fileprivate init() { }
        
        private let token: () throws -> Void = {
            processedArguments.githubToken = nextArgument
            Keychain(server: "https://github.com", protocolType: .https)["before-setup-token"] = nextArgument
        }
        
        private let repo: () throws -> Void = {
            let tokens = nextArgument.split(separator: "/").map(String.init)
            guard tokens.count == 2 else { throw GeneralError.invalidInput(nextArgument) }
            processedArguments.repositories.removeAll()
            processedArguments.repositories.append((owner: tokens[0], name: tokens[1], configurationsURL: nil))
        }
        
        private let config: () throws -> Void = {
            processedArguments.defaultConfigurationsURL = URL(fileURLWithPath: nextArgument)
        }
    }
    
    class WithoutUserInput {
        fileprivate init() { }
        
        private let help: () throws -> Void = {
            Terminal.output(
                """
                
                BeforeSetup, version \(beforeSetupVersion)
                Copyright © 2018 TintPoint. MIT license.
                
                --help                    print help information
                --version                 print currently installed BeforeSetup version
                --token <GitHubToken>     pass in a valid GitHub token
                --repo <Owner>/<Name>     pass in the owner and name of the repository
                --config <FilePath>       pass in the path to the config file, default is ".beforesetup.yaml"
                
                If some arguments aren't provided, BeforeSetup will fallback to use environment variables.
                
                BEFORE_SETUP_TOKEN        specific a valid GitHub token
                BEFORE_SETUP_REPO         specific the owner and name of the repository
                BEFORE_SETUP_CONFIG       specific the path to the config file, default is ".beforesetup.yaml"
                
                """
            )
            exit(0)
        }
        
        private let version: () throws -> Void = {
            Terminal.output(
                """
                
                BeforeSetup, version \(beforeSetupVersion)
                
                """
            )
            exit(0)
        }
    }
}
