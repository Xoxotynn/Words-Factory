import UIKit
import SnapKit
import TPKeyboardAvoidingSwift

// MARK: Strings
private extension Strings {
    static let searchPlaceholder = "Enter a word"
    
    static let wordCellId = String(describing: WordCell.self)
    static let meaningsHeaderId = String(describing: MeaningsHeader.self)
    static let definitionCellId = String(describing: DefinitionCell.self)
}

class DictionaryViewController: UIViewController {

    // MARK: Properties
    private let viewModel: DictionaryViewModel
    
    private let searchTextField = ActionTextField(actionImage: .searchIcon)
    private let wordTableView = TPKeyboardAvoidingTableView()
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
        setupTableView()
        setupSearchTextField()
//        setupTopicView()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(searchTextField)
        view.addSubview(wordTableView)
//        view.addSubview(topicView)
    }
    
    private func setupTableView() {
        wordTableView.delegate = self
        wordTableView.dataSource = self
        wordTableView.keyboardDismissMode = .interactive
        wordTableView.backgroundColor = .appWhite
        wordTableView.separatorStyle = .none
        wordTableView.register(
            WordCell.self,
            forCellReuseIdentifier: Strings.wordCellId)
        wordTableView.register(
            MeaningsHeader.self,
            forHeaderFooterViewReuseIdentifier: Strings.meaningsHeaderId)
        wordTableView.register(
            DefinitionCell.self,
            forCellReuseIdentifier: Strings.definitionCellId)
        
        wordTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        wordTableView.contentLayoutGuide.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupSearchTextField() {
        searchTextField.actionTextFieldDelegate = self
        searchTextField.setPlaceholder(Strings.searchPlaceholder)
        
        searchTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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

// MARK: UITableViewDelegate & UITableViewDataSource
extension DictionaryViewController: UITableViewDelegate & UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 10
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.section == 0 {
                guard let wordCell = tableView.dequeueReusableCell(
                    withIdentifier: Strings.wordCellId,
                    for: indexPath) as? WordCell else {
                        return UITableViewCell()
                }
                
                return wordCell
            }
            
            guard let definitionCell = tableView.dequeueReusableCell(
                withIdentifier: Strings.definitionCellId,
                for: indexPath) as? DefinitionCell else {
                    return UITableViewCell()
            }
            
            return definitionCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: Strings.meaningsHeaderId) as? MeaningsHeader,
              section > 0 else {
            return nil
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let height = min(max(Dimensions.standartHeight - offset, 1), Dimensions.standartHeight)
        let relativeHeight = height / Dimensions.standartHeight
        searchTextField.isHidden = relativeHeight < 0.5
        searchTextField.updateContent(forChangedHeight: height)
        searchTextField.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
}

// MARK: ActionTextFieldDelegate
extension DictionaryViewController: ActionTextFieldDelegate {
    func actionTextFieldDidTapAction(_ sender: ActionTextField) {
        sender.text = "Success!"
    }
}
