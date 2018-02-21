import Foundation

class ProcessedArguments {
    fileprivate(set) var githubToken: String?
    fileprivate(set) var repositoryOwner: String?
    fileprivate(set) var repositoryName: String?
    fileprivate(set) var configurationsURL: URL = URL(fileURLWithPath: ".beforesetup.yaml")
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
        }
        
        private let repo: () throws -> Void = {
            let tokens = nextArgument.split(separator: "/").map(String.init)
            guard tokens.count == 2 else { throw GeneralError.invalidInput(nextArgument) }
            processedArguments.repositoryOwner = tokens[0]
            processedArguments.repositoryName = tokens[1]
        }
        
        private let config: () throws -> Void = {
            processedArguments.configurationsURL = URL(fileURLWithPath: nextArgument)
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
