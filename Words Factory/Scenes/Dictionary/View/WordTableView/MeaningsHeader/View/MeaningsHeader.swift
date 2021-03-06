import UIKit
import SnapKit

// MARK: Dimensions
private extension Dimensions {
    static let bottomHeaderPadding: CGFloat = 11
}

class MeaningsHeader: UITableViewHeaderFooterView {

    // MARK: - Properties
    private let speechPartTitleLabel = UILabel()
    private let speechPartLabel = UILabel()
    private let meaningsTitleLabel = UILabel()

    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with viewModel: MeaningsHeaderViewModel) {
        viewModel.didSetupSpeechPart = { [weak self] in
            self?.speechPartLabel.text = viewModel.speechPart
        }
        
        viewModel.setupSpeechPArt()
    }
    
    // MARK: - Private setup methods
    private func setup() {
        addSubview(speechPartTitleLabel)
        addSubview(speechPartLabel)
        addSubview(meaningsTitleLabel)
        
        setupSpeechPartTitleLabel()
        setupSpeechPartLabel()
        setupMeaningsTitleLabel()
    }
    
    private func setupSpeechPartTitleLabel() {
        speechPartTitleLabel.text = R.string.dictionary.speechPartHeader()
        speechPartTitleLabel.textColor = R.color.black()
        speechPartTitleLabel.font = .heading5
        
        speechPartTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupSpeechPartLabel() {
        speechPartLabel.textColor = R.color.black()
        speechPartLabel.font = .paragraphMedium
        
        speechPartLabel.snp.makeConstraints { make in
            make.centerY.equalTo(speechPartTitleLabel)
            make.leading.equalTo(speechPartTitleLabel.snp.trailing)
                .offset(Dimensions.standart)
        }
    }
    
    private func setupMeaningsTitleLabel() {
        meaningsTitleLabel.text = R.string.dictionary.meaningsHeader()
        meaningsTitleLabel.textColor = R.color.black()
        meaningsTitleLabel.font = .heading5
        
        meaningsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(speechPartTitleLabel.snp.bottom)
                .offset(Dimensions.standart)
            make.bottom.equalToSuperview()
                .inset(Dimensions.bottomHeaderPadding)
            make.leading.equalTo(speechPartTitleLabel)
        }
    }
}
