import UIKit
import SnapKit

// MARK: Strings
private extension Strings {
    static let example = "Example: "
}

// MARK: Dimensions
private extension Dimensions {
    static let cellBottomMargin: CGFloat = 10
    static let cellCornerRadius: CGFloat = 16
}

class DefinitionCell: UITableViewCell {

    // MARK: Properties
    private let definitionContentView = UIView()
    private let definitionStackView = UIStackView()
    private let definitionLabel = UILabel()
    private let exampleLabel = UILabel()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
//    func configure(with viewModel) {
//
//    }
    
    // MARK: Private setup methods
    private func setup() {
        setupCell()
        setupDefinitionContentView()
        setupDefinitionStackView()
        setupDefinitionLabel()
        setupExampleLabel()
    }
    
    private func setupCell() {
        selectionStyle = .none
        
        addSubview(definitionContentView)
        definitionContentView.addSubview(definitionStackView)
        definitionStackView.addArrangedSubview(definitionLabel)
        definitionStackView.addArrangedSubview(exampleLabel)
    }
    
    private func setupDefinitionContentView() {
        definitionContentView.layer.cornerRadius = Dimensions.cellCornerRadius
        definitionContentView.layer.borderColor = UIColor.gray?.cgColor
        definitionContentView.layer.borderWidth = Dimensions.smallBorderWidth
        
        definitionContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
                .inset(Dimensions.cellBottomMargin)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupDefinitionStackView() {
        definitionStackView.axis = .vertical
        definitionStackView.spacing = Dimensions.small
        
        definitionStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupDefinitionLabel() {
        definitionLabel.text = "The practice or skill of preparing food by combining, mixing, and heating ingredients."
        definitionLabel.textColor = .dark
        definitionLabel.font = .paragraphMedium
        definitionLabel.numberOfLines = 0
    }
    
    private func setupExampleLabel() {
        exampleLabel.text = "\(Strings.example)he developed an interest in cooking."
        exampleLabel.textColor = .dark
        exampleLabel.font = .paragraphMedium
        exampleLabel.numberOfLines = 0
    }
}
