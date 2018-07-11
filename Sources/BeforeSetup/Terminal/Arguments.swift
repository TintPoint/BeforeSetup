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
    fileprivate(set) var githubToken: String?
    fileprivate(set) var defaultDirectoryURL: URL
    fileprivate(set) var defaultConfigurationsURL: URL
    fileprivate(set) var repositories: [(owner: String, name: String, configurationsURL: URL?)]

    init() {
        githubToken = Keychain(service: beforeSetupIdentifier)["token"]
        if #available(macOS 10.12, *) {
            defaultDirectoryURL = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".beforesetup", isDirectory: true)
        } else {
            defaultDirectoryURL = URL(fileURLWithPath: "~/.beforesetup", isDirectory: true)
        }
        defaultConfigurationsURL = URL(fileURLWithPath: ".beforesetup.yaml")
        repositories = []
        updateRepositories()
    }

    func updateRepositories() {
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
    }
}

class SupportedArguments {
    static let withUserInput = WithUserInput()
    static let withoutUserInput = WithoutUserInput()

    typealias Processor = () throws -> Void

    // Use global variables to workaround Swift's readwrite reflection limitation
    static var processedArguments: ProcessedArguments!
    static var nextArgument: String!

    class WithUserInput {
        fileprivate init() {}

        private let token: Processor = {
            processedArguments.githubToken = nextArgument
            Keychain(service: beforeSetupIdentifier)["token"] = nextArgument
        }

        private let configdir: Processor = {
            processedArguments.defaultDirectoryURL = URL(fileURLWithPath: nextArgument)
            processedArguments.updateRepositories()
        }

        private let config: Processor = {
            processedArguments.defaultConfigurationsURL = URL(fileURLWithPath: nextArgument)
        }

        private let repo: Processor = {
            let tokens = nextArgument.split(separator: "/").map(String.init)
            guard tokens.count == 2 else { throw GeneralError.invalidInput(nextArgument) }
            processedArguments.repositories.removeAll()
            processedArguments.repositories.append((owner: tokens[0], name: tokens[1], configurationsURL: nil))
        }
    }

    class WithoutUserInput {
        fileprivate init() {}

        private let help: Processor = {
            Terminal.output(
                """
                
                BeforeSetup, version \(beforeSetupVersion)
                Copyright © 2018 TintPoint. MIT license.
                
                --help                    print help information
                --version                 print currently installed BeforeSetup version
                --token <GitHubToken>     pass in a valid GitHub token
                --configdir <FilePath>    pass in the path to the config directory storing all config files
                                          default is "~/.beforesetup/"
                --config <FilePath>       pass in the path to the config file
                                          default is ".beforesetup.yaml"
                --repo <Owner>/<Name>     pass in the repository you want to check
                                          specify this will make BeforeSetup ignore config directory option
                
                If some arguments aren't provided, BeforeSetup will fallback to use environment variables.
                
                BEFORE_SETUP_TOKEN        specific a valid GitHub token
                BEFORE_SETUP_REPO         specific the owner and name of the repository
                BEFORE_SETUP_CONFIG       specific the path to the config file
                BEFORE_SETUP_CONFIGDIR    specific the path to the config directory storing all config files

                Example config directory structure:

                - .beforesetup (directory)
                  - <RepositoryOwner> (directory)
                    - <RepositoryNameA>.yaml (config file)
                    - <RepositoryNameB>.yaml (config file)
                  - <RepositoryOwner> (directory)
                    - <RepositoryNameC>.yaml (config file)
                    - <RepositoryNameD>.yaml (config file)
                
                """
            )
            exit(0)
        }

        private let version: Processor = {
            Terminal.output(
                """
                
                BeforeSetup, version \(beforeSetupVersion)
                
                """
            )
            exit(0)
        }
    }
}
