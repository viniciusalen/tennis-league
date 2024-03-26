import Foundation

typealias SendSignInLinkCompletionBlock = (Result<NoContent, AuthError>) -> Void
typealias SignInLinkCompletionBlock = (Result<NoContent, AuthError>) -> Void

protocol LoginServicing {
    func sendSignInLink(toEmail: String, _ completion: @escaping SendSignInLinkCompletionBlock)
    func signInLink(url: URL, _ completion: @escaping SignInLinkCompletionBlock)
}

final class LoginService {
    typealias Dependencies = HasNoDependency
    private let dependencies: Dependencies
    private let coreAuth = CoreAuth()

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - LoginServicing
extension LoginService: LoginServicing {
    func sendSignInLink(toEmail: String, _ completion: @escaping SendSignInLinkCompletionBlock) {
        coreAuth.sendSignInLink(emailString: toEmail, then: completion)
    }
    
    func signInLink(url: URL, _ completion: @escaping SignInLinkCompletionBlock) {
        coreAuth.signInLink(url: url, then: completion)
    }
}

