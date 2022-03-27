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
    /// Rubik-Bold, Size 56
    static let heading1 = rubik(.bold, size: 56)
    /// Rubik-Bold, Size 40
    static let heading2 = rubik(.bold, size: 40)
    /// Rubik-Bold, Size 32
    static let heading3 = rubik(.bold, size: 32)
    /// Rubik-Medium, Size 24
    static let heading4 = rubik(.medium, size: 24)
    /// Rubik-Medium, Size 20
    static let heading5 = rubik(.medium, size: 20)
    
    /// Rubik-Regular, Size 16
    static let paragraphLarge = rubik(.regular, size: 16)
    /// Rubik-Regular, Size 14
    static let paragraphMedium = rubik(.regular, size: 14)
    /// Rubik-Medium, Size 12
    static let paragraphSmall = rubik(.medium, size: 12)
    
    /// Rubik-Medium, Size 18
    static let buttonLarge = rubik(.medium, size: 18)
    /// Rubik-Medium, Size 16
    static let buttonMedium = rubik(.medium, size: 16)
    /// Rubik-Medium, Size 14
    static let buttonSmall = rubik(.medium, size: 14)
}
