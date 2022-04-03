import UIKit

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    var rootNavigationController: UINavigationController
    var childCoordinators: [Coordinator]
    
    // MARK: - Init
    init(rootNavigationController: UINavigationController,
         dependencies: Dependencies) {
        self.rootNavigationController = rootNavigationController
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: - Public methods
    func start() {
        let tabBarController = TabBarController()
        
        tabBarController.setViewControllers(
            [
                createDictionaryController(),
                createTrainingController(),
                createVideoController()
            ],
            animated: true)
        
        rootNavigationController.setViewControllers(
            [tabBarController],
            animated: true)
    }
    
    // MARK: - Private methods
    private func createDictionaryController() -> UINavigationController {
        let navController = UINavigationController
            .createWithHiddenNavigationBar()
        let item = UITabBarItem(
            title: Strings.dictionary,
            image: R.image.dictionaryIcon(),
            selectedImage: nil)
        
        item.setTitleTextAttributes(
            [.font: UIFont.paragraphMedium],
            for: .normal)
        navController.tabBarItem = item
        
        let coordinator = DictionaryCoordinator(
            rootNavigationController: navController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        return navController
    }
    
    private func createTrainingController() -> UINavigationController {
        let navController = UINavigationController
            .createWithHiddenNavigationBar()
        let item = UITabBarItem(
            title: Strings.training,
            image: R.image.trainingIcon(),
            selectedImage: nil)
        
        item.setTitleTextAttributes(
            [.font: UIFont.paragraphMedium],
            for: .normal)
        navController.tabBarItem = item
        
        let coordinator = TrainingCoordinator(
            rootNavigationController: navController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        return navController
    }
    
    private func createVideoController() -> UINavigationController {
        let navController = UINavigationController
            .createWithHiddenNavigationBar()
        let item = UITabBarItem(
            title: Strings.video,
            image: R.image.videoIcon(),
            selectedImage: nil)
        
        item.setTitleTextAttributes(
            [.font: UIFont.paragraphMedium],
            for: .normal)
        navController.tabBarItem = item
        
        let coordinator = VideoCoordinator(
            rootNavigationController: navController,
            dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
        
        return navController
    }
}
