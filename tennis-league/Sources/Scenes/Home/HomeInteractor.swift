protocol HomeInteracting: AnyObject {
    func loadSomething()
}

final class HomeInteractor {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    private let service: HomeServicing
    private let presenter: HomePresenting

    init(service: HomeServicing, 
         presenter: HomePresenting,
         dependencies: Dependencies) {
        self.service = service
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

// MARK: - HomeInteracting
extension HomeInteractor: HomeInteracting {
    func loadSomething() {
        log()
        presenter.displaySomething()
    }
}

private extension HomeInteractor {
    func log() {
        // To be implemented
    }
}
