protocol ___VARIABLE_moduleName___Interacting: AnyObject {
    func loadSomething()
}

final class ___VARIABLE_moduleName___Interactor {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    private let service: ___VARIABLE_moduleName___Servicing
    private let presenter: ___VARIABLE_moduleName___Presenting

    init(service: ___VARIABLE_moduleName___Servicing, 
         presenter: ___VARIABLE_moduleName___Presenting,
         dependencies: Dependencies) {
        self.service = service
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

// MARK: - ___VARIABLE_moduleName___Interacting
extension ___VARIABLE_moduleName___Interactor: ___VARIABLE_moduleName___Interacting {
    func loadSomething() {
        presenter.displaySomething()
    }
}

private extension ___VARIABLE_moduleName___Interactor {
    func log() {
        // To be implemented
    }
}
