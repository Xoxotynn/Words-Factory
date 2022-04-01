import UIKit

// MARK: Dimensions
private extension Dimensions {
    static let cornerRadius: CGFloat = 12
    static let textPadding: UIEdgeInsets = UIEdgeInsets(
        top: Dimensions.standart,
        left: Dimensions.standart,
        bottom: Dimensions.standart,
        right: Dimensions.standart)
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
        bounds.inset(by: Dimensions.textPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Dimensions.textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Dimensions.textPadding)
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
        layer.borderWidth = Dimensions.smallBorderWidth
        layer.cornerRadius = Dimensions.cornerRadius
        layer.masksToBounds = true
    }
}
