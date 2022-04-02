import UIKit
import SnapKit
import TPKeyboardAvoidingSwift

// MARK: Strings
private extension Strings {
    static let searchPlaceholder = "Enter a word"
}

// MARK: Dimensions
private extension Dimensions {
    static let additionalSafeAreaInsets: CGFloat = -22
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
        
        viewModel.didUpdateWord = { [weak self] in
            self?.togglePlaceholder(isHidden: true)
            self?.wordTableView.reloadData()
        }
        
        viewModel.didRecieveError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    private func setup() {
        setupView()
        setupTableView()
        setupSearchTextField()
        setupTopicView()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        title = Strings.appTitle
        additionalSafeAreaInsets.top = Dimensions.additionalSafeAreaInsets
        
        view.addSubview(searchTextField)
        view.addSubview(wordTableView)
        view.addSubview(topicView)
    }
    
    private func setupTableView() {
        wordTableView.delegate = self
        wordTableView.dataSource = self
        wordTableView.keyboardDismissMode = .interactive
        wordTableView.backgroundColor = .appWhite
        wordTableView.separatorStyle = .none
        wordTableView.isHidden = true
        
        wordTableView.register(
            WordCell.self,
            forCellReuseIdentifier: ReuseIdentifiers.wordCellId)
        wordTableView.register(
            MeaningsHeader.self,
            forHeaderFooterViewReuseIdentifier: ReuseIdentifiers.meaningsHeaderId)
        wordTableView.register(
            DefinitionCell.self,
            forCellReuseIdentifier: ReuseIdentifiers.definitionCellId)
        
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
    
    // MARK: Private methods
    private func togglePlaceholder(isHidden: Bool) {
        topicView.isHidden = isHidden
        wordTableView.isHidden = !isHidden
    }
    
    private func dequeueWordCell(_ tableView: UITableView, )
    -> UITableViewCell {
        guard let wordCell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath) as? WordCell else {
                return UITableViewCell()
        }
        
        do {
            try wordCell.configure(
                with: viewModel.getWordCellViewModel())
        } catch {
            showError(error)
        }
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension DictionaryViewController: UITableViewDelegate & UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.getRowsNumber(inSection: section)
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let identifier = viewModel.getReuseIdentifier(
                inSection: indexPath.section)
            
            switch identifier {
            case ReuseIdentifiers.wordCellId:
                guard let wordCell = tableView.dequeueReusableCell(
                    withIdentifier: identifier,
                    for: indexPath) as? WordCell else {
                        return UITableViewCell()
                }
                
                do {
                    try wordCell.configure(
                        with: viewModel.getWordCellViewModel())
                } catch {
                    showError(error)
                }
                
                return wordCell
            default:
                guard let definitionCell = tableView.dequeueReusableCell(
                    withIdentifier: identifier,
                    for: indexPath) as? DefinitionCell else {
                        return UITableViewCell()
                }
                
                do {
                    try definitionCell.configure(
                        with: viewModel.getDefinitionCellViewModel(
                            forRow: indexPath.row,
                            inSection: indexPath.section))
                } catch {
                    showError(error)
                }
                
                return definitionCell
            }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = viewModel.getHeaderReuseIdentifier(inSection: section)
        guard let identifier = identifier else { return nil }

        switch identifier {
        case ReuseIdentifiers.meaningsHeaderId:
            guard let headerCell = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: identifier) as? MeaningsHeader else {
                return nil
            }
            
            do {
                try headerCell.configure(
                    with: viewModel.getMeaningsHeaderViewModel(
                        inSection: section))
            } catch {
                showError(error)
            }
            
            return headerCell
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.getHeightForHeader(inSection: section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = viewModel.getSearchTextFieldHeight(
            withOffset: scrollView.contentOffset.y)
        
        navigationController?.isNavigationBarHidden = viewModel
            .isNavigationBarHidden(forHeight: height)
        
        searchTextField.updateContent(forChangedHeight: height)
        searchTextField.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
    }
}

// MARK: ActionTextFieldDelegate
extension DictionaryViewController: ActionTextFieldDelegate {
    func actionTextFieldDidTapAction(_ sender: ActionTextField) {
        viewModel.getWord(sender.text)
    }
}
