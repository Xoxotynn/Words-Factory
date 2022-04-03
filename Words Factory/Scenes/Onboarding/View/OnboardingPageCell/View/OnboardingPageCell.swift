import UIKit
import SnapKit

// MARK: - Dimensions
private extension Dimensions {
    static let topCellPadding: CGFloat = 112
}

class OnboardingPageCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let topicView = TopicView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with viewModel: OnboardingPageCellViewModel) {
        viewModel.didSetupTopicInfo = { [weak self] topic in
            self?.updateTopic(topic)
        }
        
        viewModel.setupTopicInfo()
    }
    
    // MARK: - Private setup methods
    private func setup() {
        backgroundColor = .clear
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
                .inset(Dimensions.small)
            make.top.lessThanOrEqualToSuperview()
                .inset(Dimensions.topCellPadding)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.setupAsTitle()
        titleLabel.numberOfLines = 2
        
        titleLabel.setContentCompressionResistancePriority(
            .required,
            for: .vertical)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
                .offset(Dimensions.standart)
            make.bottom.equalTo(subtitleLabel.snp.top)
                .offset(-Dimensions.small)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupDescriptionLabel() {
        subtitleLabel.setupAsSubtitle()
        subtitleLabel.numberOfLines = 0
        
        subtitleLabel.setContentCompressionResistancePriority(
            .required,
            for: .vertical)
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.medium)
        }
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.top.lessThanOrEqualToSuperview()
                .offset(Dimensions.topCellPadding)
            make.bottom.equalToSuperview()
                .inset(Dimensions.standart)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    private func updateTopic(_ topic: TopicInfo) {
        imageView.image = UIImage(named: topic.image)
        titleLabel.text = topic.title
        subtitleLabel.text = topic.subtitle
    }
}
