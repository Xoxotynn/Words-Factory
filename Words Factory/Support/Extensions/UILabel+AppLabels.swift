import UIKit

extension UILabel {
    func setupAsTitle() {
        font = .heading4
        textColor = .dark
        textAlignment = .center
    }
    
    func setupAsSubtitle() {
        font = .paragraphMedium
        textColor = .darkGray
        textAlignment = .center
    }
}
