import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    let dependencies: Dependencies
    
    var childCoordinators: [Coordinator]
    var rootNavigationController: UINavigationController
    
    private let window: UIWindow
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        dependencies = Dependencies(networkService: NetworkService())
        childCoordinators = []
        rootNavigationController = UINavigationController()
    }
    
    // MARK: Public methods
    func start() {
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        showOnBoardingScene()
    }
    
    func finish() {
        
    }
    
    // MARK: Private methods
    func showOnBoardingScene() {
        
    }
    
    func showSignUpScene() {
        
    }
}
