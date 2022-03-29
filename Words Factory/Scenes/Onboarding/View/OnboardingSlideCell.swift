import UIKit
import SnapKit

// MARK: Dimensions
private extension Dimensions {
    static let topCellPadding: CGFloat = 96
    static let mediumHorizontalMargin: CGFloat = 34
}

class OnboardingSlideCell: UICollectionViewCell {
    
    // MARK: Properties
    private let slideImageView = UIImageView()
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
    func configure(with viewModel: OnboardingSlideCellViewModel) {
        slideImageView.image = viewModel.slideImage
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
    }
    
    // MARK: Private setup methods
    private func setup() {
        backgroundColor = .clear
        addSubview(slideImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        setupSlideImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupSlideImageView() {
        slideImageView.contentMode = .scaleAspectFit
        
        slideImageView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview()
                .offset(Dimensions.topCellPadding)
            make.bottom.equalTo(titleLabel.snp.top)
                .offset(-Dimensions.standart)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.font = .heading4
        titleLabel.textColor = .dark
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top)
                .offset(-Dimensions.small)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.textColor = .darkGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 2
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Dimensions.standart)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.mediumHorizontalMargin)
        }
    }
}
