import UIKit

class TrainingCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    var rootViewController: UIViewController {
        rootNavigationController
    }
    var childCoordinators: [Coordinator]
    
    private let rootNavigationController: UINavigationController
    
    // MARK: - Init
    init(rootNavigationController: UINavigationController,
         dependencies: Dependencies) {
        self.rootNavigationController = rootNavigationController
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: - Public methods
    func start() {
        let viewModel = TrainingViewModel()
        let viewController = TrainingViewController(viewModel: viewModel)
        rootNavigationController.setViewControllers(
            [viewController],
            animated: true)
    }
}
