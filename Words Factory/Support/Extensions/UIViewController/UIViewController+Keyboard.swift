import UIKit

extension UIViewController {
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
