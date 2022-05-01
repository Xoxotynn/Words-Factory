import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    var rootViewController: UIViewController {
        rootNavigationController
    }
    var childCoordinators: [Coordinator]
    
    private let window: UIWindow
    private let rootNavigationController: UINavigationController
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        dependencies = Dependencies(
            wordsRepository: WordsDataRepository(
                remoteDataSource: NetworkService(),
                localDataSource: CoreDataService()),
            audioService: AudioService())
        childCoordinators = []
        rootNavigationController = UINavigationController
            .createWithHiddenNavigationBar()
    }
    
    // MARK: - Public methods
    func start() {
//        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
//        let startCoordinator = OnboardingCoordinator(
//            rootNavigationController: rootNavigationController,
//            dependencies: dependencies)
//        startCoordinator.delegate = self
//        childCoordinators.append(startCoordinator)
//        startCoordinator.start()
        
        let coordinator = TabBarCoordinator(
            window: window,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
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
            window: window,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
