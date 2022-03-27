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

extension UIFont {
    static let heading1 = rubik(.bold, size: 56)
    static let heading2 = rubik(.bold, size: 40)
    static let heading3 = rubik(.bold, size: 32)
    static let heading4 = rubik(.medium, size: 24)
    static let heading5 = rubik(.medium, size: 20)
    
    static let paragraphLarge = rubik(.regular, size: 16)
    static let paragraphMedium = rubik(.regular, size: 14)
    static let paragraphSmall = rubik(.medium, size: 12)
    
    static let buttonLarge = rubik(.medium, size: 18)
    static let buttonMedium = rubik(.medium, size: 16)
    static let buttonSmall = rubik(.medium, size: 14)
}
