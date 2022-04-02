import UIKit

class TrainingCoordinator: Coordinator {
    
    // MARK: Properties
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
    
    // MARK: Public methods
    func start() {
        let viewModel = TrainingViewModel()
        let viewController = TrainingViewController(viewModel: viewModel)
        rootNavigationController.setViewControllers([viewController],
                                                    animated: true)
    }
}