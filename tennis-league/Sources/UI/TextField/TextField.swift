import UIKit

final class TextField: UITextField {
    let insets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 24)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    private func setupStyle() {
        clearButtonMode = .whileEditing
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = UIFont.preferredFont(forTextStyle: .body)
        backgroundColor = .systemBackground
        layer.cornerRadius = 12
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
