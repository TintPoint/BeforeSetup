import Foundation

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
