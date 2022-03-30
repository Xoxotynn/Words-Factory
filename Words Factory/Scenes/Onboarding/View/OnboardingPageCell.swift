import UIKit
import SnapKit

// MARK: Dimensions
private extension Dimensions {
    static let topCellPadding: CGFloat = 96
    static let mediumHorizontalMargin: CGFloat = 34
}

class OnboardingPageCell: UICollectionViewCell {
    
    // MARK: Properties
    private let pageImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    func configure(with viewModel: OnboardingPageCellViewModel) {
        viewModel.didUpdatePageInfo = { [weak self] page in
            self?.pageImageView.image = page.image
            self?.titleLabel.text = page.title
            self?.descriptionLabel.text = page.description
        }
        
        viewModel.setup()
    }
    
    // MARK: Private setup methods
    private func setup() {
        backgroundColor = .clear
        addSubview(pageImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        setupPageImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupPageImageView() {
        pageImageView.contentMode = .scaleAspectFit
        
        pageImageView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview()
                .offset(Dimensions.topCellPadding)
            make.bottom.equalTo(titleLabel.snp.top)
                .offset(-Dimensions.standart)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.setupAsTitle()
        titleLabel.numberOfLines = 2
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top)
                .offset(-Dimensions.small)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.setupAsSubtitle()
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Dimensions.standart)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.mediumHorizontalMargin)
        }
    }
}
