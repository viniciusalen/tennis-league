import UIKit

open class ViewControllerPublisher: UIViewController {
    struct WeakValue {
        weak var value: ViewControllerObserver?
    }
    
    private var observers = [WeakValue]()
    
    public var currentObservers: [ViewControllerObserver] {
        observers.compactMap(\.value)
    }
    
    private var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
    
    private let notificationCenter = NotificationCenter.default
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        observers.forEach({ $0.value?.viewDidLoad() })
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        observers.forEach({ $0.value?.viewWillAppear() })
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observers.forEach({ $0.value?.viewDidAppear() })
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        observers.forEach({ $0.value?.viewDidDisappear() })
    }
    
    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        observers.forEach({ $0.value?.didMoveBack() })
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        observers.forEach({ $0.value?.traitCollectionDidChange(darkModeEnable: isDarkMode) })
    }
    
    @objc
    open func willEnterForeground() {
        observers.forEach({ $0.value?.willEnterForeground() })
    }
    
    @objc
    open func didBecomeActive() {
        observers.forEach({ $0.value?.didBecomeActive() })
    }
    
    @objc
    open func appMovedToBackground() {
        observers.forEach({ $0.value?.appMovedToBackground() })
    }
    
    private func addObserver() {
        notificationCenter.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    private func removeObserver() {
        notificationCenter.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
    }
}

public extension ViewControllerPublisher {
    func observer<T>(_ type: T.Type, execution: @escaping (T) -> Void) {
        let observerList = currentObservers.compactMap { $0 as? T }
        observerList.forEach { execution($0) }
    }
}
