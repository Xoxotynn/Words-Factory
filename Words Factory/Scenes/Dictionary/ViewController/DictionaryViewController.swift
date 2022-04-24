import UIKit
import SnapKit
import TPKeyboardAvoidingSwift

// MARK: - Dimensions
private extension Dimensions {
    static let additionalSafeAreaInsets: CGFloat = -22
    static let tableViewInsets: UIEdgeInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: Dimensions.standartHeight + 2 * Dimensions.standart,
        right: 0)
}

class DictionaryViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: DictionaryViewModel
    
    private let searchTextField = ActionTextField(
        actionImage: R.image.searchIcon())
    private let wordTableView = TPKeyboardAvoidingTableView()
    private let addToDictionaryButton = StandartButton()
    private let topicView = TopicView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Init
    init(viewModel: DictionaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        topicView.configure(with: viewModel.topicViewModel)
        setup()
    }
    
    // MARK: - Private setup methods
    private func bindToViewModel() {
        viewModel.didHidePlaceholder = { [weak self] hidden in
            self?.togglePlaceholder(isHidden: hidden)
        }
        
        viewModel.didUpdateWord = { [weak self] in
            self?.updateWord()
        }
        
        viewModel.didStartLoading = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.didEndLoading = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        
        viewModel.didReceiveError = { [weak self] error in
            self?.showError(error)
        }
    }
    
    private func setup() {
        setupView()
        setupSearchTextField()
        setupTableView()
        setupAddToDictionaryButton()
        setupTopicView()
        setupActivityIndicator()
    }
    
    private func setupView() {
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)))
        view.backgroundColor = R.color.white()
        navigationItem.title = viewModel.title
        additionalSafeAreaInsets.top = Dimensions.additionalSafeAreaInsets
        
        view.addSubview(searchTextField)
        view.addSubview(wordTableView)
        view.addSubview(addToDictionaryButton)
        view.addSubview(topicView)
        view.addSubview(activityIndicator)
    }
    
    private func setupTableView() {
        wordTableView.delegate = self
        wordTableView.dataSource = self
        wordTableView.keyboardDismissMode = .interactive
        wordTableView.contentInset = Dimensions.tableViewInsets
        wordTableView.backgroundColor = R.color.white()
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
        searchTextField.delegate = self
        searchTextField.actionTextFieldDelegate = self
        searchTextField.setPlaceholder(R.string.dictionary.searchPlaceholder())
        
        searchTextField.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    private func setupAddToDictionaryButton() {
        addToDictionaryButton.addTarget(
            self,
            action: #selector(addToDictionary),
            for: .touchUpInside)
        addToDictionaryButton.setTitle(
            R.string.dictionary.addToDictionary(),
            for: .normal)
        addToDictionaryButton.isHidden = true
        
        addToDictionaryButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.medium)
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = R.color.darkGray()
        
        activityIndicator.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Private methods
    private func togglePlaceholder(isHidden: Bool) {
        topicView.isHidden = isHidden
        wordTableView.isHidden = !isHidden
        addToDictionaryButton.isHidden = !isHidden
    }
    
    private func updateWord() {
        hideKeyboard()
        navigationItem.title = viewModel.title
        wordTableView.reloadData()
    }
    
    private func dequeueWordCell(_ tableView: UITableView,
                                 forRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let wordCell = tableView.dequeueReusableCell(
            withIdentifier: ReuseIdentifiers.wordCellId,
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
    }
    
    private func dequeueDefinitionCell(_ tableView: UITableView,
                                       forRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let definitionCell = tableView.dequeueReusableCell(
            withIdentifier: ReuseIdentifiers.definitionCellId,
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
    
    func dequeueMeaningsHeader(_ tableView: UITableView,
                               inSection section: Int) -> UIView? {
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ReuseIdentifiers.meaningsHeaderId)
                as? MeaningsHeader else {
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
    }
    
    // MARK: - Actions
    @objc private func addToDictionary() {
        viewModel.addToDictionary()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
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
                return dequeueWordCell(tableView, forRowAt: indexPath)
            default:
                return dequeueDefinitionCell(tableView, forRowAt: indexPath)
            }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = viewModel.getHeaderReuseIdentifier(inSection: section)

        switch identifier {
        case ReuseIdentifiers.meaningsHeaderId:
            return dequeueMeaningsHeader(tableView, inSection: section)
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

// MARK: - ActionTextFieldDelegate, UITextFieldDelegate
extension DictionaryViewController:
    ActionTextFieldDelegate, UITextFieldDelegate {
    func actionTextFieldDidTapAction(_ textField: ActionTextField) {
        viewModel.getWord(textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        viewModel.getWord(textField.text)
        
        return true
    }
}
