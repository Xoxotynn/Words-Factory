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

// MARK: - DataError
enum DataError {
    case notFound
    case creationFailed
    case unexpected
}

// MARK: - SystemError description
extension SystemError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .indexOutOfRange:
            return R.string.errors.systemOutOfRange()
        }
    }
}

// MARK: - ValidationError description
extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyField:
            return R.string.errors.validationEmptyField()
        case .invalidName:
            return R.string.errors.validationName()
        case .invalidEmail:
            return R.string.errors.validationEmail()
        case .invalidPassword:
            return R.string.errors.validationPassword()
        case .unexpected:
            return R.string.errors.unexpected()
        }
    }
}

// MARK: - DataError description
extension DataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return R.string.errors.dataNotFound()
        case .creationFailed:
            return R.string.errors.dataSave()
        case .unexpected:
            return R.string.errors.unexpected()
        }
    }
}
