import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDynamicLinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let windowScene = UIWindow(frame: UIScreen.main.bounds)
        
        if Auth.auth().currentUser == nil {
            windowScene.rootViewController = LoginFactory.make()
        } else {
            windowScene.rootViewController = HomeFactory.make()
        }
        windowScene.makeKeyAndVisible()
        
        window = windowScene
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("url aqui: \(url.absoluteString)")
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            print("Incoming URL is \(incomingURL)")
            let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { receivedDynamicLink, error in
                guard error == nil else {
                    print("Found an error! \(error!.localizedDescription)")
                    return
                }
                if let dynamicLink = receivedDynamicLink {
                    self.handleIncomingDynamicLink(dynamicLink)
                }
            }
            if linkHandled {
                return true
            } else {
                // Maybe do other things with our incoming url
                return false
            }
        }
        return false
    }
    
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink) {
        guard let url = dynamicLink.url else {
            print("Thats WEIRD. My dynamic link object has no url")
            return
        }
        print("Your incoming link paremeter is \(url.absoluteString)")
    }
}

