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
    
    lazy var textField: TextField = {
        let tf = TextField()
        tf.placeholder = "Primeiro nome"
        tf.keyboardType = .alphabet
        tf.autocapitalizationType = .words
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var button: Button = {
        let button = Button(title: "Entrar com e-mail")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.loadSomething()
    }

    override func buildViewHierarchy() {
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    override func configureViews() {
        title = "Entrar"
        view.backgroundColor = .systemGray6
        navigationItem.largeTitleDisplayMode = .never
    }
}

// MARK: - HomeDisplaying
extension HomeViewController: HomeDisplaying {
    func displaySomething() {
        // template
    }
}
