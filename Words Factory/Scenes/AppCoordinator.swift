import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    let dependencies: Dependencies
    
    var rootNavigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    private let window: UIWindow
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        dependencies = Dependencies(networkService: NetworkService())
        childCoordinators = []
        rootNavigationController = UINavigationController()
        rootNavigationController.isNavigationBarHidden = true
    }
    
    // MARK: Public methods
    func start() {
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = OnboardingCoordinator(
            rootNavigationController: rootNavigationController,
            dependencies: dependencies)
        startCoordinator.start()
    }
}
