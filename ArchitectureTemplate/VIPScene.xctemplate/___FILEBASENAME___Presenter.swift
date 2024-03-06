protocol ___VARIABLE_moduleName___Presenting: AnyObject {
    func displaySomething()
    func didNextStep()
}

final class ___VARIABLE_moduleName___Presenter {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    private let coordinator: ___VARIABLE_moduleName___Coordinating
    weak var viewController: ___VARIABLE_moduleName___Displaying?

    init(coordinator: ___VARIABLE_moduleName___Coordinating, dependencies: Dependencies) {
        self.coordinator = coordinator
        self.dependencies = dependencies
    }
}

// MARK: - ___VARIABLE_moduleName___Presenting
extension ___VARIABLE_moduleName___Presenter: ___VARIABLE_moduleName___Presenting {
    func displaySomething() {
        viewController?.displaySomething()
    }
    
    func didNextStep() {
        coordinator.openSomething()
    }
}

