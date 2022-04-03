import UIKit

extension UILabel {
    func setupAsTitle() {
        font = .heading4
        textColor = R.color.black()
        textAlignment = .center
    }
    
    func setupAsSubtitle() {
        font = .paragraphMedium
        textColor = R.color.darkGray()
        textAlignment = .center
    }
}
