import UIKit
import SnapKit

class TopicView: UIView {
    
    // MARK: - Properties
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with viewModel: TopicViewModel) {
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
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top)
                .offset(-Dimensions.standart)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.setupAsTitle()
        titleLabel.numberOfLines = 2
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitleLabel.snp.top)
                .offset(-Dimensions.small)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupDescriptionLabel() {
        subtitleLabel.setupAsSubtitle()
        subtitleLabel.numberOfLines = 0
        
        subtitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.medium)
        }
    }
    
    // MARK: - Private methods
    private func updateTopic(_ topic: TopicInfo) {
        imageView.image = UIImage(named: topic.image)
        titleLabel.text = topic.title
        subtitleLabel.text = topic.subtitle
    }
}
