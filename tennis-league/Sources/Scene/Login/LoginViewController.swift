import UIKit

protocol LoginDisplaying: AnyObject {
    func displaySomething()
}

private extension LoginViewController.Layout {
    // example
    enum Size {
        static let imageHeight: CGFloat = 90.0
    }
}

final class LoginViewController: ViewController<LoginInteracting, UIView> {
    fileprivate enum Layout {
        // template
    }
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.loadInitialState()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("HandleOpenURL"), object: nil)
    }

    override func buildViewHierarchy() {
        view.addSubview(emailTextField)
        view.addSubview(loginButton)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    override func configureViews() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - LoginDisplaying
extension LoginViewController: LoginDisplaying {
    func displaySomething() {
        // template
    }
}

extension LoginViewController {
    @objc
    func loginButtonTapped() {
        interactor.didTapLoginButton()
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        interactor.didEndEditingTextField(with: textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
