import UIKit

class StandartButton: UIButton {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        backgroundColor = R.color.orange()
        layer.cornerRadius = Dimensions.standart
        layer.masksToBounds = true
        
        titleLabel?.font = .buttonMedium
        setTitleColor(R.color.white(), for: .normal)
    }
}
