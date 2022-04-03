import UIKit

// MARK: - OnboardingCoordinatorDelegate
protocol OnboardingCoordinatorDelegate: AnyObject {
    func replaceOnboardingWithSignUp(_ onboardingCoordinator: OnboardingCoordinator)
}

class OnboardingCoordinator: Coordinator {
    
    // MARK: - Properties
    let dependencies: Dependencies
    
    weak var delegate: OnboardingCoordinatorDelegate?
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
        let viewModel = OnboardingViewModel()
        viewModel.delegate = self
        let viewController = OnboardingViewController(viewModel: viewModel)
        rootNavigationController.setViewControllers([viewController],
                                                    animated: true)
    }
}

// MARK: - OnboardingViewModelDelegate
extension OnboardingCoordinator: OnboardingViewModelDelegate {
    func showSignUpScene() {
        delegate?.replaceOnboardingWithSignUp(self)
    }
}
