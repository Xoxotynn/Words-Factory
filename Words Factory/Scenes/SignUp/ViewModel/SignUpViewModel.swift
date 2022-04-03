import UIKit

// MARK: - Strings
private extension Strings {
    static let createAccount = "Create your account"
}

// MARK: - SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
    func showTabBarScene()
}

class SignUpViewModel {
    
    // MARK: - Properties
    weak var delegate: SignUpViewModelDelegate?
    
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    var didRecieveErrors: (([Error]) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: .standingKid2 ?? UIImage(),
            title: Strings.signUp,
            subtitle: Strings.createAccount))
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
    
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
