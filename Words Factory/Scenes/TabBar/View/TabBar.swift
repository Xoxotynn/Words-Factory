import UIKit

// MARK: - Dimensions
private extension Dimensions {
    static let tabBarHeight: CGFloat = 64
}

class TabBar: UITabBar {
    
    // MARK: - Overrided methods
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        
        guard let window = window else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom +
                              Dimensions.tabBarHeight
        return sizeThatFits
    }
}
