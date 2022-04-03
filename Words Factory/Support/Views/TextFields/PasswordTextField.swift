import UIKit

// MARK: - Images
private extension Images {
    static let hideIcon = "HideIcon"
    static let showIcon = "ShowIcon"
}

// MARK: - PasswordTextFieldDelegate
protocol PasswordTextFieldDelegate: AnyObject {
    func passwordTextFieldDidToggleVisibility(_ textField: PasswordTextField)
}

class PasswordTextField: ActionTextField {
    
    // MARK: - Properties
    weak var passwordTextFieldDelegate: PasswordTextFieldDelegate?
    
    // MARK: - Init
    init() {
        super.init(actionImage: UIImage(named: Images.hideIcon))
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
                                   ? UIImage(named: Images.hideIcon)
                                   : UIImage(named: Images.showIcon))
        passwordTextFieldDelegate?.passwordTextFieldDidToggleVisibility(self)
    }
}
