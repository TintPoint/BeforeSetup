import Apollo
import Foundation

enum GeneralError: LocalizedError {
    case missingToken
    case missingRepository
    case argumentExpectsMoreParameters(String)
    case invalidInput(String)

    var errorDescription: String? {
        switch self {
        case .missingToken: return "Remote GitHub settings couldn't be retrieved because GitHub access token is missing."
        case .missingRepository: return "No repository to check."
        case let .argumentExpectsMoreParameters(argument): return "Argument \(argument) expects more parameters."
        case let .invalidInput(input): return "Input \(input) is invalid. Checkout `beforesetup --help` for more information."
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidBaseURLString(String)
    case emptyQueryResult
    case graphQLErrors([GraphQLError])

    var errorDescription: String? {
        switch self {
        case let .invalidBaseURLString(baseURL): return "The URL \(baseURL) couldn't be opened."
        case .emptyQueryResult: return "Remote GitHub settings couldn't be retrieved."
        case let .graphQLErrors(errors): return errors.map { $0.localizedDescription }.reduce("", +)
        }
    }
}
