import Foundation

class Terminal {
    let environment: [String: String]
    let userInputs: [String]
    let arguments: ProcessedArguments
    
    init(processInfo: ProcessInfo) throws {
        environment = processInfo.environment
        userInputs = processInfo.arguments
        arguments = ProcessedArguments()
        try processArguments()
    }
}

private extension Terminal {
    func processArguments() throws {
        SupportedArguments.processedArguments = arguments
        let supportedArgumentsWithUserInput = Mirror(reflecting: SupportedArguments.withUserInput).children
        for case (let label?, let function as SupportedArguments.Processor) in supportedArgumentsWithUserInput {
            if let index = userInputs.index(of: "--\(label.lowercased())") {
                if userInputs.indices.contains(index + 1) {
                    SupportedArguments.nextArgument = userInputs[index + 1]
                    try function()
                } else {
                    throw GeneralError.argumentExpectsMoreParameters(label)
                }
            } else if let nextArgument = environment["BEFORE_SETUP_\(label.uppercased())"] {
                SupportedArguments.nextArgument = nextArgument
                try function()
            }
        }
        let supportedArgumentsWithoutUserInput = Mirror(reflecting: SupportedArguments.withoutUserInput).children
        for case (let label?, let function as SupportedArguments.Processor) in supportedArgumentsWithoutUserInput where userInputs.contains("--\(label.lowercased())") {
            try function()
        }
        SupportedArguments.processedArguments = nil
        SupportedArguments.nextArgument = nil
    }
}
