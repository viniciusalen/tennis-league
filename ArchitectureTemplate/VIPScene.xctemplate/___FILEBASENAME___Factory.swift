import UIKit

enum ___VARIABLE_moduleName___Factory {
    static func make() -> UIViewController {
        let container = DependencyContainer()
        let service = ___VARIABLE_moduleName___Service(dependencies: container)
        let coordinator = ___VARIABLE_moduleName___Coordinator(dependencies: container)
        let presenter = ___VARIABLE_moduleName___Presenter(coordinator: coordinator, dependencies: container)
        let interactor = ___VARIABLE_moduleName___Interactor(service: service, presenter: presenter, dependencies: container)
        let viewController = ___VARIABLE_moduleName___ViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
