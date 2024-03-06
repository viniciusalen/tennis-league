import UIKit

protocol ___VARIABLE_moduleName___Coordinating: AnyObject {
    func openSomething()
}

final class ___VARIABLE_moduleName___Coordinator {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    weak var viewController: UIViewController?

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - ___VARIABLE_moduleName___Coordinating
extension ___VARIABLE_moduleName___Coordinator: ___VARIABLE_moduleName___Coordinating {
    func openSomething() {
        // template
    }
}
