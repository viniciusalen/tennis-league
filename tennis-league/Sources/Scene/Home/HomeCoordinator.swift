import UIKit

protocol HomeCoordinating: AnyObject {
    func openSomething()
}

final class HomeCoordinator {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    weak var viewController: UIViewController?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - HomeCoordinating
extension HomeCoordinator: HomeCoordinating {
    func openSomething() {
        // template
    }
}
