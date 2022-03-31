import Foundation

final class Validator {
    
    // MARK: Init
    private init() { }
    
    // MARK: Public methods
    static func validateSignUpCredentials(name: String?,
                                          email: String?,
                                          password: String?) -> [Error] {
        var errors: [Error] = []
        guard let name = name,
              let email = email,
              let password = password else {
            errors.append(ValidationError.emptyField)
            return errors
        }
        
        guard !name.isEmpty && !email.isEmpty && !password.isEmpty else {
            errors.append(ValidationError.emptyField)
            return errors
        }
        
        if let error = validate(name: name) {
            errors.append(error)
        }
        
        if let error = validate(email: email) {
            errors.append(error)
        }
        
        if let error = validate(password: password) {
            errors.append(error)
        }
        
        return errors
    }
    
    // MARK: Private methods
    private static func validate(name: String) -> Error? {
        return name.count < 3 ? ValidationError.invalidName : nil
    }
    
    private static func validate(email: String) -> Error? {
        return !email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .contains("@") ? ValidationError.invalidEmail : nil
    }
    
    private static func validate(password: String) -> Error? {
        return password.count < 8 ? ValidationError.invalidPassword : nil
    }
}
