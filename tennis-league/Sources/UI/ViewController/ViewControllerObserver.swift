import Foundation

public protocol ViewControllerObserver: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func didBecomeActive()
    func willEnterForeground()
    func appMovedToBackground()
    func traitCollectionDidChange(darkModeEnable: Bool)
    func didMoveBack()
}

public extension ViewControllerObserver {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    func didBecomeActive() {}
    func willEnterForeground() {}
    func appMovedToBackground() {}
    func traitCollectionDidChange(darkModeEnable: Bool) {}
    func didMoveBack() {}
}
