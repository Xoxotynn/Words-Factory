import Foundation

// MARK: SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
    func showTabBarScene()
}

class SignUpViewModel {
    
    // MARK: Properties
    weak var delegate: SignUpViewModelDelegate?
    
    var didRecieveErrors: (([Error]) -> Void)?
    
    // MARK: Public methods
    func signUp(name: String?, email: String?, password: String?) {
        let errors = Validator.validateSignUpCredentials(
            name: name,
            email: email,
            password: password)
        
        guard errors.isEmpty else {
            didRecieveErrors?(errors)
            return
        }
        
        delegate?.showTabBarScene()
    }
}
