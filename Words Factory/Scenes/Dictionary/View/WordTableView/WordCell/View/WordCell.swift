import UIKit
import SnapKit

class WordCell: UITableViewCell {
    
    // MARK: - Properties
    private let wordLabel = UILabel()
    private let phoneticsStackView = UIStackView()
    private let phoneticsLabel = UILabel()
    private let audioImageView = UIImageView()
    
    private var viewModel: WordCellViewModel?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(with viewModel: WordCellViewModel) {
        self.viewModel = viewModel
        
        viewModel.didSetupWord = { [weak self] in
            self?.updateWord()
        }
        
        viewModel.setupWord()
    }
    
    // MARK: - Private setup methods
    private func setup() {
        selectionStyle = .none
        addGestureRecognizer(
            UITapGestureRecognizer(target: self,
                                   action: #selector(playAudio)))
        
        addSubview(wordLabel)
        addSubview(phoneticsStackView)
        phoneticsStackView.addArrangedSubview(phoneticsLabel)
        phoneticsStackView.addArrangedSubview(audioImageView)
        
        setupWordLabel()
        setupPhoneticsStackView()
        setupPhoneticsLabel()
        setupAudioImageView()
    }
    
    private func setupWordLabel() {
        wordLabel.textColor = .dark
        wordLabel.font = .heading4
        
        wordLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupPhoneticsStackView() {
        phoneticsStackView.spacing = Dimensions.standart
        phoneticsStackView.alignment = .center
        
        phoneticsStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(wordLabel)
            make.leading.equalTo(wordLabel.snp.trailing)
                .offset(Dimensions.standart)
        }
    }
    
    private func setupPhoneticsLabel() {
        phoneticsLabel.textColor = .primary
        phoneticsLabel.font = .paragraphMedium
    }
    
    private func setupAudioImageView() {
        audioImageView.image = UIImage(named: Images.soundIcon)
        audioImageView.tintColor = .primary
        audioImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Private methods
    func updateWord() {
        wordLabel.text = viewModel?.word
        phoneticsLabel.text = viewModel?.phoneticText
    }
    
    // MARK: - Actions
    @objc private func playAudio() {
        viewModel?.playAudio()
    }
}
