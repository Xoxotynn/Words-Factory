import UIKit

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
    func showTabBarScene()
}

class SignUpViewModel {
    
    // MARK: - Properties
    weak var delegate: SignUpViewModelDelegate?
    
    var didReceiveErrors: (([Error]) -> Void)?
    
    let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.standingKid2.name,
            title: R.string.signUp.signUp(),
            subtitle: R.string.signUp.createAccount()))
    
    // MARK: - Public methods
    func signUp(name: String?, email: String?, password: String?) {
        let errors = Validator.validateSignUpCredentials(
            name: name,
            email: email,
            password: password)
        
        guard errors.isEmpty else {
            didReceiveErrors?(errors)
            return
        }
        
        delegate?.showTabBarScene()
    }
}
