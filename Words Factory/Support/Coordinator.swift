import UIKit

protocol Coordinator: AnyObject {
    var rootNavigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func removeAllChildCoordinatorsWithType<T: Coordinator>(_ type: T.Type)
}

extension Coordinator {
    func removeAllChildCoordinatorsWithType<T: Coordinator>(_ type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
}
