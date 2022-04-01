import UIKit

extension UINavigationController {
    static func createWithHiddenNavigationBar() -> UINavigationController {
        let navController = UINavigationController()
        navController.isNavigationBarHidden = true
        return navController
    }
}
