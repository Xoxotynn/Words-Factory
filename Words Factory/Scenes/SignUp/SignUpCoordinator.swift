import UIKit

// MARK: SignUpCoordinatorDelegate
protocol SignUpCoordinatorDelegate: AnyObject {
    func replaceSignUpWithTabBar(_ signUpCoordinator: SignUpCoordinator)
}

class SignUpCoordinator: Coordinator {
    
    // MARK: Properties
    let dependencies: Dependencies
    
    weak var delegate: SignUpCoordinatorDelegate?
    var rootNavigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    // MARK: - Init
    init(rootNavigationController: UINavigationController,
         dependencies: Dependencies) {
        self.rootNavigationController = rootNavigationController
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: Public methods
    func start() {
        let viewController = SignUpViewController()
        rootNavigationController.setViewControllers([viewController],
                                                    animated: true)
    }
}
