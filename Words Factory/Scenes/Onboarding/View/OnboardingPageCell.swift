import UIKit
import SnapKit

// MARK: - Dimensions
private extension Dimensions {
    static let topCellPadding: CGFloat = 112
}

class OnboardingPageCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let topicView = TopicView()
    
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
        viewModel.didSetupTopicInfo = { [weak self] topicViewModel in
            self?.topicView.configure(with: topicViewModel)
        }
        
        viewModel.setupTopicInfo()
    }
    
    // MARK: - Private setup methods
    private func setup() {
        backgroundColor = .clear
        addSubview(topicView)
        
        setupTopicView()
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
}
