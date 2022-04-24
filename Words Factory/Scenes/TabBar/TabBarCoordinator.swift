import UIKit

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    var rootViewController: UIViewController {
        rootTabBarController
    }
    var childCoordinators: [Coordinator]
    
    private let window: UIWindow
    private let rootTabBarController: UITabBarController
    
    // MARK: - Init
    init(window: UIWindow,
         dependencies: Dependencies) {
        self.window = window
        self.rootTabBarController = TabBarController()
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: - Public methods
    func start() {
        rootTabBarController.setViewControllers(
            [
                createDictionaryController(),
                createTrainingController(),
                createVideoController()
            ],
            animated: true)
        
        window.rootViewController = rootTabBarController
    }
    
    // MARK: - Private methods
    private func createDictionaryController() -> UIViewController {
        let navController = UINavigationController
            .createWithHiddenNavigationBar()
        let item = UITabBarItem(
            title: R.string.localizable.tabBarDictionary(),
            image: R.image.dictionaryIcon(),
            selectedImage: nil)
        
        item.setTitleTextAttributes(
            [.font: UIFont.paragraphMedium ?? UIFont.systemMedium],
            for: .normal)
        navController.tabBarItem = item
        
        let coordinator = DictionaryCoordinator(
            rootNavigationController: navController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        return navController
    }
    
    private func createTrainingController() -> UIViewController {
        let navController = UINavigationController
            .createWithHiddenNavigationBar()
        let item = UITabBarItem(
            title: R.string.localizable.tabBarTraining(),
            image: R.image.trainingIcon(),
            selectedImage: nil)
        
        item.setTitleTextAttributes(
            [.font: UIFont.paragraphMedium ?? UIFont.systemMedium],
            for: .normal)
        navController.tabBarItem = item
        
        let coordinator = TrainingCoordinator(
            rootNavigationController: navController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        return navController
    }
    
    private func createVideoController() -> UIViewController {
        let coordinator = VideoCoordinator(dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        let viewController = coordinator.rootViewController
        let item = UITabBarItem(
            title: R.string.localizable.tabBarVideo(),
            image: R.image.videoIcon(),
            selectedImage: nil)
        
        item.setTitleTextAttributes(
            [.font: UIFont.paragraphMedium ?? UIFont.systemMedium],
            for: .normal)
        viewController.tabBarItem = item
        
        return viewController
    }
}
