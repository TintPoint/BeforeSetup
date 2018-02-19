import Foundation

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

enum Terminal {
    enum OutputStream {
        case standardOutput, standardError
    }

    static func output(_ string: String, to outputStream: OutputStream = .standardOutput) {
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
