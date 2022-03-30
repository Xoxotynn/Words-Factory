import UIKit

// MARK: Strings
private extension Strings {
    static let defaultTitle = "Oops..."
    static let defaultMessage = "It seems something went wrong"
    static let ok = "Ok"
    static let attributedTitleKey = "attributedTitle"
    static let attributedMessageKey = "attributedMessage"
}

// MARK: UIViewController+Alerts
extension UIViewController {
    
    func showAlert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
        alert.setValuesForKeys([
            Strings.attributedTitleKey:
                NSAttributedString(
                    string: title ?? Strings.defaultTitle,
                    attributes: [
                        .font: UIFont.heading5,
                        .foregroundColor: UIColor.dark ?? .black
                       ]),
            Strings.attributedMessageKey:
                NSAttributedString(
                    string: message ?? Strings.defaultMessage,
                    attributes: [
                        .font: UIFont.paragraphMedium,
                        .foregroundColor: UIColor.darkGray ?? .systemGray4
                       ])
        ])
        
        let okAction = UIAlertAction(title: Strings.ok,
                                     style: .default,
                                     handler: nil)
        alert.view.tintColor = .primary
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func showError(_ error: Error, withTitle title: String? = nil) {
        showAlert(title: title,
                  message: error.localizedDescription)
    }
}
