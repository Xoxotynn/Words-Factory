import Foundation

// MARK: SignUpViewModelDelegate
protocol SignUpViewModelDelegate: AnyObject {
    func showDictionaryScene()
}

class SignUpViewModel {
    
    // MARK: Properties
    weak var delegate: SignUpViewModelDelegate?
}
