import UIKit
import SnapKit
import TPKeyboardAvoidingSwift

// MARK: Strings
private extension Strings {
    static let searchPlaceholder = "Enter a word"
}

class DictionaryViewController: UIViewController {

    // MARK: Properties
    private let viewModel: DictionaryViewModel
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let searchTextField = ActionTextField(actionImage: .searchIcon)
    private let topicView = TopicView()
    
    // MARK: Init
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        viewModel.setupTopic()
        setup()
    }
    
    // MARK: Private setup methods
    private func bindToViewModel() {
        viewModel.didSetupTopicInfo = { [weak self] topicViewModel in
            self?.topicView.configure(with: topicViewModel)
        }
    }
    
    private func setup() {
        setupView()
        setupScrollView()
        setupSearchTextField()
        setupTopicView()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(scrollView)
        scrollView.addSubview(searchTextField)
        scrollView.addSubview(topicView)
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupSearchTextField() {
        searchTextField.actionTextFieldDelegate = self
        searchTextField.setPlaceholder(Strings.searchPlaceholder)
        
        searchTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: ActionTextFieldDelegate
extension DictionaryViewController: ActionTextFieldDelegate {
    func actionTextFieldDidTapAction(_ sender: ActionTextField) {
        sender.text = "Success!"
    }
}
