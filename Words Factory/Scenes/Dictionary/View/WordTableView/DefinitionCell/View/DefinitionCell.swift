import UIKit
import SnapKit

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
    func configure(with viewModel: DefinitionCellViewModel) {
        viewModel.didSetupDefinition = { [weak self] in
            self?.definitionLabel.text = viewModel.definition
        }
        
        viewModel.didSetupExample = { [weak self] in
            self?.exampleLabel.attributedText = viewModel.attributedExample
        }
        
        viewModel.didNotFoundExample = { [weak self] in
            self?.exampleLabel.isHidden = true
        }
        
        viewModel.setupDefinition()
    }
    
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
        definitionLabel.textColor = .dark
        definitionLabel.font = .paragraphMedium
        definitionLabel.numberOfLines = 0
    }
    
    private func setupExampleLabel() {
        exampleLabel.textColor = .dark
        exampleLabel.font = .paragraphMedium
        exampleLabel.numberOfLines = 0
    }
}
