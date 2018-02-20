import Foundation
import Apollo

enum GeneralError: LocalizedError {
    case missingToken
    var errorDescription: String? {
        switch self {
        case .missingToken: return "GitHub token is missing. You should setup environment variable BEFORE_SETUP_TOKEN."
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidBaseURLString(String)
    case emptyQueryResult
    case graphQLErrors([GraphQLError])
    var errorDescription: String? {
        switch self {
        case .invalidBaseURLString(let baseURL): return "The URL \(baseURL) couldn't be opened."
        case .emptyQueryResult: return "Current GitHub settings couldn't be retrieved."
        case .graphQLErrors(let errors): return errors.map { $0.localizedDescription }.reduce("", +)
        }
    }
}
