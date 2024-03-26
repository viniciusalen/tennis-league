import UIKit

final class Button: UIButton {
    let buttonText: String
    
    required init(title: String) {
        self.buttonText = title
        super.init(frame: .zero)
        setupButton()
    }
    
    private func setupButton() {
        setTitle(buttonText, for: .normal)
        setTitleColor(.systemBackground, for: .normal)
        backgroundColor = UIColor.darkGray
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = .preferredFont(forTextStyle: .callout)
        setTitleColor(.systemGray4, for: .highlighted)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
