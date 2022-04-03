import UIKit

// MARK: Images
private extension UIImage {
    static let hideIcon = UIImage(named: "HideIcon")
    static let showIcon = UIImage(named: "ShowIcon")
}

// MARK: PasswordTextFieldDelegate
protocol PasswordTextFieldDelegate: AnyObject {
    func passwordTextFieldDidToggleVisibility(_ textField: PasswordTextField)
}

class PasswordTextField: ActionTextField {
    
    // MARK: Properties
    weak var passwordTextFieldDelegate: PasswordTextFieldDelegate?
    
    // MARK: Init
    init() {
        super.init(actionImage: .hideIcon)
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

extension PasswordTextField: ActionTextFieldDelegate {
    func actionTextFieldDidTapAction(_ sender: ActionTextField) {
        sender.isSecureTextEntry = !sender.isSecureTextEntry
        sender.setRightActionImage(withImage: isSecureTextEntry
                                   ? .hideIcon : .showIcon)
        passwordTextFieldDelegate?.passwordTextFieldDidToggleVisibility(self)
    }
}
