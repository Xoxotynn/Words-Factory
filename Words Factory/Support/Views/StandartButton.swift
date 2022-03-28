import UIKit

private extension Dimensions {
    static let cornerRadius: CGFloat = 16
}

class StandartButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .primary
        layer.cornerRadius = Dimensions.cornerRadius
        layer.masksToBounds = true
        
        titleLabel?.font = .buttonMedium
        setTitleColor(.appWhite, for: .normal)
    }
}
