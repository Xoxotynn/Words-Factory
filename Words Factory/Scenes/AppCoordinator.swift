import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    var rootNavigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    private let window: UIWindow
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        dependencies = Dependencies(
            wordsRepository: WordsDataRepository(
                remoteDataSource: NetworkService(),
                localDataSource: CoreDataService()),
            audioService: AudioService())
        childCoordinators = []
        rootNavigationController = UINavigationController()
        rootNavigationController.isNavigationBarHidden = true
    }
    
    // MARK: - Public methods
    func start() {
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let startCoordinator = OnboardingCoordinator(
            rootNavigationController: rootNavigationController,
            dependencies: dependencies)
        startCoordinator.delegate = self
        childCoordinators.append(startCoordinator)
        startCoordinator.start()
    }
}

// MARK: - OnboardingCoordinatorDelegate
extension AppCoordinator: OnboardingCoordinatorDelegate {
    func replaceOnboardingWithSignUp(_ onboardingCoordinator: OnboardingCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: onboardingCoordinator))
        let coordinator = SignUpCoordinator(
            rootNavigationController: rootNavigationController,
            dependencies: dependencies)
        coordinator.delegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

// MARK: - SignUpCoordinatorDelegate
extension AppCoordinator: SignUpCoordinatorDelegate {
    func replaceSignUpWithTabBar(_ signUpCoordinator: SignUpCoordinator) {
        removeAllChildCoordinatorsWithType(type(of: signUpCoordinator))
        let coordinator = TabBarCoordinator(
            rootNavigationController: rootNavigationController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
