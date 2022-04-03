import UIKit

extension UIFont {
    /// System-Bold, Size 24
    static let systemLarge = UIFont.systemFont(ofSize: 24, weight: .bold)
    /// System-Regular, Size 14
    static let systemMedium = UIFont.systemFont(ofSize: 14, weight: .regular)
    /// System-Medium, Size 12
    static let systemSmall = UIFont.systemFont(ofSize: 12, weight: .medium)
    
    /// Rubik-Bold, Size 56
    static let heading1 = R.font.rubikBold(size: 56)
    /// Rubik-Bold, Size 40
    static let heading2 = R.font.rubikBold(size: 40)
    /// Rubik-Bold, Size 32
    static let heading3 = R.font.rubikBold(size: 32)
    /// Rubik-Medium, Size 24
    static let heading4 = R.font.rubikMedium(size: 24)
    /// Rubik-Medium, Size 20
    static let heading5 = R.font.rubikMedium(size: 20)
    
    /// Rubik-Regular, Size 16
    static let paragraphLarge = R.font.rubikRegular(size: 16)
    /// Rubik-Regular, Size 14
    static let paragraphMedium = R.font.rubikRegular(size: 14)
    /// Rubik-Medium, Size 12
    static let paragraphSmall = R.font.rubikMedium(size: 12)
    
    /// Rubik-Medium, Size 18
    static let buttonLarge = R.font.rubikMedium(size: 18)
    /// Rubik-Medium, Size 16
    static let buttonMedium = R.font.rubikMedium(size: 16)
    /// Rubik-Medium, Size 14
    static let buttonSmall = R.font.rubikMedium(size: 14)
}
