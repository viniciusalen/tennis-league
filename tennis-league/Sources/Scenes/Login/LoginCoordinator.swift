import UIKit

protocol LoginCoordinating: AnyObject {
    func openSomething()
}

final class LoginCoordinator {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    weak var viewController: UIViewController?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - LoginCoordinating
extension LoginCoordinator: LoginCoordinating {
    func openSomething() {
        // template
    }
}
