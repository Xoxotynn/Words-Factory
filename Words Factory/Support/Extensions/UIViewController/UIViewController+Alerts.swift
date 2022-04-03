import UIKit

extension UIViewController {
    
    // MARK: Public methods
    func showAlert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
        alert.setValuesForKeys([
            AttributedKeys.alertTitle:
                NSAttributedString(
                    string: title ?? R.string.localizable.alertTitle(),
                    attributes: [
                        .font: UIFont.heading4 ?? UIFont.systemLarge,
                        .foregroundColor: R.color.black() ?? .black
                       ]),
            AttributedKeys.alertMessage:
                NSAttributedString(
                    string: message ?? R.string.localizable.alertMessage(),
                    attributes: [
                        .font: UIFont.paragraphLarge ?? UIFont.systemMedium,
                        .foregroundColor: R.color.darkGray() ?? .systemGray4
                       ])
        ])
        
        let okAction = UIAlertAction(
            title: R.string.localizable.alertButtonTitle(),
            style: .default,
            handler: nil)
        alert.view.tintColor = R.color.orange()
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func showError(_ error: Error, withTitle title: String? = nil) {
        showAlert(title: title,
                  message: error.localizedDescription)
    }
    
    func showMultipleErrors(_ errors: [Error],
                            withTitle title: String? = nil) {
        showAlert(
            title: title,
            message: errors.reduce("") { partialResult, error in
                partialResult + "• \(error.localizedDescription)\n"
            }.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
