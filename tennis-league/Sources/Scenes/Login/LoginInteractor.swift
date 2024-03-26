import Foundation

protocol LoginInteracting: AnyObject {
    func didTapLoginButton()
    func didEndEditingTextField(with text: String?)
    func loadInitialState()
}

final class LoginInteractor {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies

    private var emailTextValue: String?
    private var urlOpenned: URL?
    private let service: LoginServicing
    private let presenter: LoginPresenting

    init(service: LoginServicing, 
         presenter: LoginPresenting,
         dependencies: Dependencies) {
        self.service = service
        self.presenter = presenter
        self.dependencies = dependencies
    }
}

// MARK: - LoginInteracting
extension LoginInteractor: LoginInteracting {
    func didTapLoginButton() {
        guard let safeEmailText = emailTextValue else { return }
        sendSignInlink(with: safeEmailText)
    }
    
    func didEndEditingTextField(with text: String?) {
        self.emailTextValue = text
        
    }
    
    func loadInitialState() {
        presenter.displaySomething()
        createUrlObserver()
    }
}

private extension LoginInteractor {
    func sendSignInlink(with safeEmailText: String) {
        service.sendSignInLink(toEmail: safeEmailText) { [weak self] result in
            switch result {
            case .success:
               print("SUCCESS")
            case .failure(let authError):
                break
            }
        }
    }
    
    func createUrlObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOpenURL(notification:)),
            name: NSNotification.Name("HandleOpenURL"),
            object: nil
        )
    }
    
    @objc
    func handleOpenURL(notification: Notification) {
        guard let urlOpenned = notification.userInfo?["url"] as? URL
        else {
            return print("DEEPLINK FAILS")
        }
        service.signInLink(url: urlOpenned) { [weak self] result in
            switch result {
            case .success:
               print("SUCCESS authentcation: CONGRATULATIONS")
            case .failure(let authError):
                break
            }
        }
    }
    
    func log() {
        // To be implemented
    }
}
