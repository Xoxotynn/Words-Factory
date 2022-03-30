import UIKit

// MARK: Dimensions
private extension Dimensions {
    static let cornerRadius: CGFloat = 12
    static let borderWidth: CGFloat = 1
    static let padding: CGFloat = 16
}

class TextField: UITextField {
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrided methods
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: bounds.origin.x + Dimensions.padding,
               y: bounds.origin.y + Dimensions.padding,
               width: bounds.width - 2 * Dimensions.padding,
               height: bounds.height - 2 * Dimensions.padding)
    }
    
    // MARK: Public methods
    func setPlaceholder(_ text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: UIColor.darkGray ?? .systemGray3
            ])
    }
    
    // MARK: Private methods
    private func setup() {
        autocorrectionType = .no
        font = .paragraphMedium
        textColor = .dark
        layer.borderColor = UIColor.gray?.cgColor
        layer.borderWidth = Dimensions.borderWidth
        layer.cornerRadius = Dimensions.cornerRadius
        layer.masksToBounds = true
    }
}
