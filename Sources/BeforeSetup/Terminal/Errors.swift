import Foundation
import Apollo

enum GeneralError: LocalizedError {
    case missingToken
    case missingRepositoryName
    case missingRepositoryOwner
    case argumentExpectsOneMoreParameter(String)
    case processArgumentInternalError
    case invalidInput(String)
    var errorDescription: String? {
        switch self {
        case .missingToken: return "Remote GitHub settings couldn't be retrieved because GitHub access token is missing."
        case .missingRepositoryName: return "Remote GitHub settings couldn't be retrieved because repository name is missing."
        case .missingRepositoryOwner: return "Remote GitHub settings couldn't be retrieved because repository owner is missing."
        case .argumentExpectsOneMoreParameter(let argument): return "Argument \(argument) expects one more parameter."
        case .processArgumentInternalError: return "An internal error occurred while processing arguments."
        case .invalidInput(let input): return "Input \(input) is invalid. Checkout `beforesetup --help` for more information."
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
        case .emptyQueryResult: return "Remote GitHub settings couldn't be retrieved."
        case .graphQLErrors(let errors): return errors.map { $0.localizedDescription }.reduce("", +)
        }
    }
}
