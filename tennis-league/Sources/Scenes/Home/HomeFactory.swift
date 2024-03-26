import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let container = DependencyContainer()
        let service = HomeService(dependencies: container)
        let coordinator = HomeCoordinator(dependencies: container)
        let presenter = HomePresenter(coordinator: coordinator, dependencies: container)
        let interactor = HomeInteractor(service: service, presenter: presenter, dependencies: container)
        let viewController = HomeViewController(interactor: interactor)

        coordinator.viewController = viewController
        presenter.viewController = viewController

        return viewController
    }
}
