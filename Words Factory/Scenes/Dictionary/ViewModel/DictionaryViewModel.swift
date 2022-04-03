import UIKit

// MARK: Strings
extension Strings {
    static let noWordTitle = "No word"
    static let noWordSubtitle = "Input something to find it in dictionary"
}

// MARK: Dimensions
private extension Dimensions {
    static let showingNavBarHeight: CGFloat = 0.25
}

class DictionaryViewModel {
    
    // MARK: Properties
    var numberOfSections: Int {
        (word?.meanings.count ?? -1) + 1
    }
    
    var didSetupPlaceholderTopicInfo: ((TopicViewModel) -> Void)?
    var didHidePlaceholder: ((Bool) -> Void)?
    var didUpdateWord: (() -> Void)?
    var didRecieveError: ((Error) -> Void)?
    
    private let networkService: NetworkService
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: .standingKid ?? UIImage(),
            title: Strings.noWordTitle,
            subtitle: Strings.noWordSubtitle))
    
    private var wordCellViewModel: WordCellViewModel?
    private var meaningsHeaderViewModels: [MeaningsHeaderViewModel]
    private var definitionCellViewModels: [[DefinitionCellViewModel]]
    private var word: Word?
    
    // MARK: Init
    init(networkService: NetworkService) {
        self.networkService = networkService
        meaningsHeaderViewModels = []
        definitionCellViewModels = []
    }
    
    // MARK: Public methods
    func setupTopic() {
        didSetupPlaceholderTopicInfo?(topicViewModel)
    }
    
    func getWordCellViewModel() throws -> WordCellViewModel {
        guard let wordCellViewModel = wordCellViewModel else {
            throw NetworkError.notFound
        }

        return wordCellViewModel
    }
    
    func getMeaningsHeaderViewModel(inSection section: Int) throws
    -> MeaningsHeaderViewModel {
        guard section > 0, section <= meaningsHeaderViewModels.count else {
            throw SystemError.indexOutOfRange
        }
        
        return meaningsHeaderViewModels[section - 1]
    }
    
    func getDefinitionCellViewModel(forRow row: Int, inSection section: Int)
    throws -> DefinitionCellViewModel {
        guard section > 0,
              section <= definitionCellViewModels.count,
              row >= 0,
              row < definitionCellViewModels[section - 1].count else {
            throw SystemError.indexOutOfRange
        }
        
        return definitionCellViewModels[section - 1][row]
    }
    
    func getWord(_ word: String?) {
        guard let word = word?.trimmingCharacters(in: .whitespacesAndNewlines),
              !word.isEmpty else {
            updateLoadedWord(nil)
            return
        }

        loadWord(word)
    }
    
    func getRowsNumber(inSection section: Int) -> Int {
        guard let word = word else { return 0 }
        guard section > 0 else { return 1 }
        guard section <= word.meanings.count else { return 0 }
        
        return word.meanings[section - 1].definitions.count
    }
    
    func getReuseIdentifier(inSection section: Int) -> String {
        switch section {
        case 0:
            return ReuseIdentifiers.wordCellId
        default:
            return ReuseIdentifiers.definitionCellId
        }
    }
    
    func getHeaderReuseIdentifier(inSection section: Int) -> String? {
        section > 0 ? ReuseIdentifiers.meaningsHeaderId : nil
    }
    
    func getHeightForHeader(inSection section: Int) -> CGFloat {
        section == 0 ? 0 : UITableView.automaticDimension
    }
    
    func getSearchTextFieldHeight(withOffset offset: CGFloat) -> CGFloat {
        min(max(Dimensions.standartHeight - offset, 0),
            Dimensions.standartHeight)
    }
    
    func isNavigationBarHidden(forHeight height: CGFloat) -> Bool {
        (height / Dimensions.standartHeight) > Dimensions.showingNavBarHeight
    }
 
    // MARK: Private methods
    private func loadWord(_ word: String) {
        networkService.wordRequest(word: word)
        { [weak self] word in
            self?.updateLoadedWord(word)
        } onFailure: { [weak self] error in
            self?.didRecieveError?(error)
        }
    }
    
    private func updateLoadedWord(_ word: Word?) {
        clearWord()
        guard let word = word else {
            return
        }

        self.word = word
        guard let phonetic = word.phonetics.first else {
            return
        }
        
        wordCellViewModel = WordCellViewModel(word: word.word,
                                              phonetic: phonetic)
        word.meanings.forEach { meaning in
            meaningsHeaderViewModels.append(
                MeaningsHeaderViewModel(speechPart: meaning.partOfSpeech))
            definitionCellViewModels.append(
                meaning.definitions.map { definition in
                    DefinitionCellViewModel(definition: definition)
                })
        }
        
        didHidePlaceholder?(true)
        didUpdateWord?()
    }
    
    private func clearWord() {
        word = nil
        wordCellViewModel = nil
        meaningsHeaderViewModels = []
        definitionCellViewModels = []
    }
}
