import UIKit

// MARK: - Dimensions
private extension Dimensions {
    static let tabBarCornerRadius: CGFloat = 16
    static let tabBarItemOffset: UIOffset = UIOffset(horizontal: 0,
                                                     vertical: -8)
}

class TabBarController: UITabBarController {
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupTabBar() {
        object_setClass(self.tabBar, TabBar.self)
        UITabBarItem
            .appearance()
            .titlePositionAdjustment = Dimensions.tabBarItemOffset
        
        tabBar.backgroundColor = R.color.white()
        tabBar.tintColor = .orange
        
        tabBar.layer.cornerRadius = Dimensions.tabBarCornerRadius
        tabBar.layer.borderWidth = Dimensions.smallBorderWidth
        tabBar.layer.borderColor = R.color.gray()?.cgColor
        tabBar.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        tabBar.layer.masksToBounds = true
    }
}
