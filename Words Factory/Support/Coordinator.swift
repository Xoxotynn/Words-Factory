import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var rootNavigationController: UINavigationController { get set }
    func start()
    func finish()
    func removeAllChildCoordinatorsWithType<T: Coordinator>(_ type: T.Type)
}

extension Coordinator {
    func removeAllChildCoordinatorsWithType<T: Coordinator>(_ type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
}
