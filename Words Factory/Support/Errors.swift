import Foundation

// MARK: - SystemError
enum SystemError {
    case indexOutOfRange
}

// MARK: - ValidationError
enum ValidationError {
    case emptyField
    case invalidName
    case invalidEmail
    case invalidPassword
    case unexpected
}

// MARK: - NetworkError
enum NetworkError {
    case notFound
    case unexpected
}

// MARK: - SystemError description
extension SystemError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return "Element index is out of range"
        }
    }
}

// MARK: - ValidationError description
extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyField:
            return "One or more fields are empty"
        case .invalidName:
            return "Name must contains 3 or more symbols"
        case .invalidEmail:
            return "Invalid email provided"
        case .invalidPassword:
            return "Password must contains 8 or more symbols"
        case .unexpected:
            return "Unexpected error"
        }
    }
}

// MARK: - NetworkError description
extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return "We can't find this word"
        case .unexpected:
            return "Something went wrong during retrieving a word"
        }
    }
}
