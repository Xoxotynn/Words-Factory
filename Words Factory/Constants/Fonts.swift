import UIKit

extension UIFont {
    enum FontType: String {
        case regular = "-Regular"
        case medium = "-Medium"
        case bold = "-Bold"
    }
    
    static func rubik(_ type: FontType = .regular,
                      size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Rubik\(type.rawValue)", size: size)
            ?? .systemFont(ofSize: size)
    }
}
