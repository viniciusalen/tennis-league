protocol HomePresenting: AnyObject {
    func displaySomething()
    func didNextStep()
}

final class HomePresenter {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    private let coordinator: HomeCoordinating
    weak var viewController: HomeDisplaying?

    init(coordinator: HomeCoordinating, dependencies: Dependencies) {
        self.coordinator = coordinator
        self.dependencies = dependencies
    }
}

// MARK: - HomePresenting
extension HomePresenter: HomePresenting {
    func displaySomething() {
        viewController?.displaySomething()
    }
    
    func didNextStep() {
        coordinator.openSomething()
    }
}

