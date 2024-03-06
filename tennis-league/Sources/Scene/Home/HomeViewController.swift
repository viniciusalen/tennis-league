import UIKit

protocol HomeDisplaying: AnyObject {
    func displaySomething()
}

private extension HomeViewController.Layout {
    // example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class HomeViewController: ViewController<HomeInteracting, UIView> {
    fileprivate enum Layout {
        // template
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.loadSomething()
    }

    override func buildViewHierarchy() {
        // template
    }
    
    override func setupConstraints() {
        // template
    }

    override func configureViews() {
        // template
    }
}

// MARK: - HomeDisplaying
extension HomeViewController: HomeDisplaying {
    func displaySomething() {
        // template
    }
}
