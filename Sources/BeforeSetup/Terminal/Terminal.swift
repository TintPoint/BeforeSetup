import Foundation

class Terminal {
    let environment: [String: String]
    let userInputArguments: [String]
    let supportedArguments: Arguments.Supported
    let processedArguments: Arguments.Processed

    init(processInfo: ProcessInfo) {
        environment = processInfo.environment
        userInputArguments = processInfo.arguments
        supportedArguments = Arguments.Supported()
        processedArguments = Arguments.Processed()
    }
    
    func processArguments() throws {
        for case let (label?, value) in Mirror(reflecting: supportedArguments).children {
            if let index = userInputArguments.index(of: "--\(label.lowercased())") {
                let argument = userInputArguments[index]
                switch value {
                case let function as () -> Void:
                    function()
                case let function as (Any, Any) throws -> Void where userInputArguments.indices.contains(index + 1):
                    try function(processedArguments, userInputArguments[index + 1])
                case _ as (Any, Any) throws -> Void:
                    throw GeneralError.argumentExpectsOneMoreParameter(argument)
                default:
                    throw GeneralError.processArgumentInternalError
                }
            }
        }
    }
}

extension Terminal {
    enum OutputStream {
        case standardOutput, standardError
    }
    
    enum OutputColor {
        case `default`, red, green, yellow
        
        fileprivate func converted(_ string: String) -> String {
            switch self {
            case .`default`: return "\u{001B}[39m\(string)"
            case .red: return "\u{001B}[31m\(string)\u{001B}[0m"
            case .green: return "\u{001B}[32m\(string)\u{001B}[0m"
            case .yellow: return "\u{001B}[33m\(string)\u{001B}[0m"
            }
        }
    }
    
    static func output(_ string: String, to outputStream: OutputStream = .standardOutput, color outputColor: OutputColor = .default) {
        let string = outputColor.converted(string)
        switch outputStream {
        case .standardOutput:
            var standardOutput = StandardOutputStream()
            print(string, to: &standardOutput)
        case .standardError:
            var standardError = StandardErrorStream()
            print(string, to: &standardError)
        }
    }
}

private extension Terminal {
    struct StandardOutputStream: TextOutputStream {
        func write(_ string: String) {
            FileHandle.standardOutput.write(Data(string.utf8))
        }
    }
    
    struct StandardErrorStream: TextOutputStream {
        func write(_ string: String) {
            FileHandle.standardError.write(Data(string.utf8))
        }
    }
}
