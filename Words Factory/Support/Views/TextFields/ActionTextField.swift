import UIKit

// MARK: ActionTextFieldDelegate
protocol ActionTextFieldDelegate: AnyObject {
    func actionTextFieldDidTapAction(_ sender: ActionTextField)
}

class ActionTextField: TextField {
    
    // MARK: Properties
    weak var actionTextFieldDelegate: ActionTextFieldDelegate?
    
    private let actionImageView = UIImageView()
    
    // MARK: Init
    init(actionImage: UIImage?) {
        super.init()
        actionImageView.image = actionImage
        setupActionImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrided methods
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: getTextInset(forBounds: bounds))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: getTextInset(forBounds: bounds))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: getTextInset(forBounds: bounds))
    }
    
    // MARK: Public methods
    func setRightActionImage(withImage image: UIImage?) {
        actionImageView.image = image
    }
    
    // MARK: Private methods
    private func setupActionImageView() {
        addSubview(actionImageView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(performAction))
        actionImageView.addGestureRecognizer(tapGestureRecognizer)
        actionImageView.isUserInteractionEnabled = true
        actionImageView.contentMode = .scaleAspectFit
        
        actionImageView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func getTextInset(forBounds bounds: CGRect) -> UIEdgeInsets {
        UIEdgeInsets(
            top: Dimensions.standart,
            left: Dimensions.standart,
            bottom: Dimensions.standart,
            right: bounds.height)
    }
    
    // MARK: Actions
    @objc private func performAction() {
        actionTextFieldDelegate?.actionTextFieldDidTapAction(self)
    }
}
