import UIKit

class VideoCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    private(set) var rootViewController: UIViewController
    var childCoordinators: [Coordinator]
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        rootViewController = UIViewController()
        self.dependencies = dependencies
        childCoordinators = []
    }
    
    // MARK: - Public methods
    func start() {
        let viewModel = VideoViewModel()
        let viewController = VideoViewController(viewModel: viewModel)
        rootViewController = viewController
    }
}
