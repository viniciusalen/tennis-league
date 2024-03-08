import UIKit

enum LoginFactory {
    static func make() -> UIViewController {
        let container = DependencyContainer()
        let service = LoginService(dependencies: container)
        let coordinator = LoginCoordinator(dependencies: container)
        let presenter = LoginPresenter(coordinator: coordinator, dependencies: container)
        let interactor = LoginInteractor(service: service, presenter: presenter, dependencies: container)
        let viewController = LoginViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
