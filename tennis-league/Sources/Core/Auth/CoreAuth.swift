import FirebaseAuth
import Foundation

protocol CoreAuthentication {
    func sendSignInLink<T: Decodable>(
        emailString: String,
        then completion: @escaping (Result<T, AuthError>) -> Void
    )
    
    func signInLink<T: Decodable>(
        url: URL,
        then completion: @escaping (Result<T, AuthError>) -> Void
    )
}

final class CoreAuth {
    private let auth = Auth.auth()
}

extension CoreAuth: CoreAuthentication {
    // MARK: - SendSignInlink
    /// SignIn using url authentication
    func signInLink<T: Decodable>(
        url: URL,
        then completion: @escaping (Result<T, AuthError>) -> Void
    ) {
        perform(url: url) { (result: Result<T, AuthError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    // MARK: - SendSignInlink
    /// Send email sign link authentication
    func sendSignInLink<T: Decodable>(
        emailString: String,
        then completion: @escaping (Result<T, AuthError>) -> Void
    ) {
        perform(emailString: emailString) { (result: Result<T, AuthError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}

private extension CoreAuth {
    func perform<T: Decodable>(
        url: URL,
        then completion: @escaping (Result<T, AuthError>) -> Void
    ) {
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmailAddress")
        else {
            logGetCachedUserEmail()
            return completion(.failure(.getCachedUserEmail))
        }
        let urlString = url.absoluteString
        if auth.isSignIn(withEmailLink: urlString) {
            auth.signIn(withEmail: userEmail, link: urlString) { [weak self] result, error in
                guard error == nil,
                      let userData = result?.user
                else {
                    self?.sendAuthErrorWith(error?.localizedDescription ?? String())
                    return completion(.failure(.authError(error)))
                }
                print("USER: \(userData.uid) signed in with email \(userData.email ?? "(unknown)"). The email is \(userData.isEmailVerified ? "" : "NOT") verified")
                UserDefaults.standard.set(nil, forKey: "userEmailAddress")
                guard let object = NoContent() as? T
                else { return completion(.failure(.noContentCastModel))}
                completion(.success(object))
            }
        }
    }
    
    // MARK: - Send Sign Email in link
    func perform<T: Decodable>(
        emailString: String,
        then completion: @escaping (Result<T, AuthError>) -> Void
    ) {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.url = URL(string: "https://alencarapps.page.link/email-link-login")
        auth.sendSignInLink(toEmail: emailString, actionCodeSettings: actionCodeSettings) { [weak self] error in
            if let err = error {
                self?.logFailsSendLinkAuthentication(err.localizedDescription)
                return completion(.failure(.sendSignInLink(error)))
            } else {
                UserDefaults.standard.set(emailString, forKey: "userEmailAddress")
                guard let object = NoContent() as? T
                else {
                    self?.logFailsCastNoContentModel()
                    return completion(.failure(.noContentCastModel))
                }
                print("Sended email to: \(emailString)")
                return completion(.success(object))
            }
        }
    }
    
    func logSucceedSendedLinkAuthentication() {
        print("----- SUCCESS AUTHENTICATION ----")
        print("SUCCESS: Sending link authentication")
    }
    
    func logFailsSendLinkAuthentication(_ localizedErrorString: String = String()) {
        print("----- FAILS AUTHENTICATION ----")
        print("ERROR: Error Sending link authentication")
        print("LocalizedError: \(localizedErrorString)")
    }
    
    func sendAuthErrorWith(_ localizedErrorString: String = String()) {
        print("----- FAILS AUTHENTICATION ----")
        print("ERROR: Error authenticating link")
        print("LocalizedError: \(localizedErrorString)")
    }
    
    func logGetCachedUserEmail() {
        print("----- FAILS GET CACHED USER E-MAIL ----")
    }
    
    func logFailsCastNoContentModel() {
        print("----- FAILS NoContent Model cast ----")
    }
}
