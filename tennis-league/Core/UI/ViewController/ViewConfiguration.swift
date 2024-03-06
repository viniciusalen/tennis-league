import UIKit

public protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func buildLayout()
}

public extension ViewConfiguration {
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() {}
}

open class ViewController<Interactor, V: UIView>: ViewControllerPublisher, ViewConfiguration {
    public var interactor: Interactor
    public var rootView = V()
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    public func buildViewHierarchy() { }
    
    public func setupConstraints() { }
    
    public func configureViews() { }
}

public extension ViewController where Interactor == Void {
    convenience init(_ interactor: Interactor = ()) {
        self.init(interactor: interactor)
    }
}
