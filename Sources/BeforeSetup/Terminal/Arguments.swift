import Foundation

enum Arguments {
    // Order of instance variables reflects the order of processing arguments
    class Supported {
        let help = {
            Terminal.output("""
                
                BeforeSetup, version \(beforeSetupVersion)
                Copyright © 2018 TintPoint. MIT license.
                
                --help                    print help information
                --version                 print currently installed BeforeSetup version
                --token <GitHubToken>     pass in a valid GitHub token
                --repo <Owner>/<Name>     pass in the owner and name of the repository
                --config <FilePath>       pass in the path to the config file, default is "./.beforesetup.yaml"
                
                If some arguments aren't provided, BeforeSetup will fallback to use environment variables.
                
                BEFORE_SETUP_TOKEN        specific a valid GitHub token
                BEFORE_SETUP_REPO_NAME    specific the name of the repository
                BEFORE_SETUP_REPO_OWNER   specific the owner of the repository
                BEFORE_SETUP_CONFIG_PATH  specific the path to the config file, default is "./.beforesetup.yaml"
                
                """)
            exit(0)
        }
        
        let version = {
            Terminal.output("""
                
                BeforeSetup, version \(beforeSetupVersion)
                
                """)
            exit(0)
        }
        
        let token: (Any, Any) throws -> Void = { processed, string in
            guard let processed = processed as? Processed else { throw GeneralError.processArgumentInternalError }
            guard let string = string as? String else { throw GeneralError.processArgumentInternalError }
            processed.githubToken = string
        }
        
        let repo: (Any, Any) throws -> Void = { processed, string in
            guard let processed = processed as? Processed else { throw GeneralError.processArgumentInternalError }
            guard let string = string as? String else { throw GeneralError.processArgumentInternalError }
            let tokens = string.split(separator: "/").map(String.init)
            guard tokens.count == 2 else { throw GeneralError.invalidInput(string) }
            processed.repository = (name: tokens[1], owner: tokens[0])
        }
        
        let config: (Any, Any) throws -> Void = { processed, string in
            guard let processed = processed as? Processed else { throw GeneralError.processArgumentInternalError }
            guard let string = string as? String else { throw GeneralError.processArgumentInternalError }
            processed.configurationsURLString = string
        }
    }
    
    class Processed {
        var githubToken: String?
        var repository: (name: String, owner: String)?
        var configurationsURLString: String?
    }
}

extension Terminal {
    func githubToken() throws -> String {
        guard let token = processedArguments.githubToken ?? environment["BEFORE_SETUP_TOKEN"] else { throw GeneralError.missingToken }
        return token
    }
    
    func repositoryName() throws -> String {
        guard let name = processedArguments.repository?.name ?? environment["BEFORE_SETUP_REPO_NAME"] else { throw GeneralError.missingRepositoryName }
        return name
    }
    
    func repositoryOwner() throws -> String {
        guard let owner = processedArguments.repository?.owner ?? environment["BEFORE_SETUP_REPO_OWNER"] else { throw GeneralError.missingRepositoryOwner }
        return owner
    }
    
    func configurationsURLString() -> String {
        return processedArguments.configurationsURLString ?? environment["BEFORE_SETUP_CONFIG_PATH"] ?? ".beforesetup.yaml"
    }
}
