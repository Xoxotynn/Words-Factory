import UIKit

// MARK: - PasswordTextFieldDelegate
protocol PasswordTextFieldDelegate: AnyObject {
    func passwordTextFieldDidToggleVisibility(_ textField: PasswordTextField)
}

class PasswordTextField: ActionTextField {
    
    // MARK: - Properties
    weak var passwordTextFieldDelegate: PasswordTextFieldDelegate?
    
    // MARK: - Init
    init() {
        super.init(actionImage: R.image.hideIcon())
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        actionTextFieldDelegate = self
        autocapitalizationType = .none
        isSecureTextEntry = true
        textContentType = .password
    }
}

// MARK: - ActionTextFieldDelegate
extension PasswordTextField: ActionTextFieldDelegate {
    func actionTextFieldDidTapAction(_ sender: ActionTextField) {
        sender.isSecureTextEntry = !sender.isSecureTextEntry
        sender.setRightActionImage(withImage: isSecureTextEntry
                                   ? R.image.hideIcon()
                                   : R.image.showIcon())
        passwordTextFieldDelegate?.passwordTextFieldDidToggleVisibility(self)
    }
}
