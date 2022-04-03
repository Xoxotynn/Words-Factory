import UIKit

// MARK: - Dimensions
private extension Dimensions {
    static let alphaOffset: CGFloat = 0.25
    static let cornerRadius: CGFloat = 12
    static let textPadding: UIEdgeInsets = UIEdgeInsets(
        top: Dimensions.standart,
        left: Dimensions.standart,
        bottom: Dimensions.standart,
        right: Dimensions.standart)
}

class TextField: UITextField {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrided methods
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Dimensions.textPadding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Dimensions.textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: Dimensions.textPadding)
    }
    
    // MARK: - Public methods
    func setPlaceholder(_ text: String, withAlpha alpha: CGFloat = 1) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: (R.color.darkGray() ?? .systemGray3)
                .withAlphaComponent(alpha)
            ])
    }
    
    func updateContent(forChangedHeight height: CGFloat) {
        let relativeHeight = height / Dimensions.standartHeight
        isHidden = relativeHeight < 0.5
        isEnabled = height == Dimensions.standartHeight
        layer.cornerRadius = relativeHeight * Dimensions.cornerRadius
        if height == Dimensions.standartHeight {
            alpha = 1
            setPlaceholder(placeholder ?? "", withAlpha: 1)
            return
        }
        
        alpha = relativeHeight - Dimensions.alphaOffset
        setPlaceholder(
            placeholder ?? "",
            withAlpha: relativeHeight - 2 * Dimensions.alphaOffset)
    }
    
    // MARK: - Private methods
    private func setup() {
        autocorrectionType = .no
        font = .paragraphMedium
        textColor = R.color.black()
        layer.borderColor = R.color.gray()?.cgColor
        layer.borderWidth = Dimensions.smallBorderWidth
        layer.cornerRadius = Dimensions.cornerRadius
        layer.masksToBounds = true
    }
}
