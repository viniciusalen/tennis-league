protocol LoginPresenting: AnyObject {
    func displaySomething()
    func didNextStep()
}

final class LoginPresenter {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    private let coordinator: LoginCoordinating
    weak var viewController: LoginDisplaying?

    init(coordinator: LoginCoordinating, dependencies: Dependencies) {
        self.coordinator = coordinator
        self.dependencies = dependencies
    }
}

// MARK: - LoginPresenting
extension LoginPresenter: LoginPresenting {
    func displaySomething() {
        viewController?.displaySomething()
    }
    
    func didNextStep() {
        coordinator.openSomething()
    }
}

