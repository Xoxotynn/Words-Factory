import UIKit

// MARK: - Dimensions
private extension Dimensions {
    static let showingNavBarHeight: CGFloat = 0.25
}

class DictionaryViewModel {
    
    // MARK: - Properties
    var title: String {
        if let word = word?.word {
            return word
        }
        return R.string.localizable.appTitle()
    }
    
    var numberOfSections: Int {
        (word?.meanings.count ?? -1) + 1
    }
    
    var didSetupPlaceholderTopicInfo: ((TopicViewModel) -> Void)?
    var didHidePlaceholder: ((Bool) -> Void)?
    var didUpdateWord: (() -> Void)?
    var didStartLoading: (() -> Void)?
    var didEndLoading: (() -> Void)?
    var didReceiveError: ((Error) -> Void)?
    
    private let wordsRepository: WordsRepository
    private let audioService: AudioService
    private let topicViewModel: TopicViewModel
    
    private var wordCellViewModel: WordCellViewModel?
    private var meaningsSectionViewModels: [MeaningsSectionViewModel]
    private var word: Word?
    
    // MARK: - Init
    init(wordsRepository: WordsRepository,
         audioService: AudioService) {
        self.wordsRepository = wordsRepository
        self.audioService = audioService
        topicViewModel = TopicViewModel(
            topic: TopicInfo(
                image: R.image.standingKid.name,
                title: R.string.dictionary.noWordTitle(),
                subtitle: R.string.dictionary.noWordSubtitle()))
        meaningsSectionViewModels = []
    }
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupPlaceholderTopicInfo?(topicViewModel)
    }
    
    func getWord(_ word: String?) {
        guard let word = word?.trimmingCharacters(in: .whitespacesAndNewlines),
              !word.isEmpty else {
            updateLoadedWord(nil)
            return
        }

        loadWord(word)
    }
    
    func addToDictionary() {
        guard let word = word else {
            didReceiveError?(DataError.unexpected)
            return
        }

        wordsRepository.add(domainWord: word)
        { word in
            
        } onFailure: { [weak self] error in
            self?.didReceiveError?(error)
        }

    }
    
    func getRowsNumber(inSection section: Int) -> Int {
        guard let _ = word,
              section <= meaningsSectionViewModels.count else { return 0 }
        guard section > 0 else { return 1 }
        
        return meaningsSectionViewModels[section - 1].rowsNumber
    }
    
    func getHeaderReuseIdentifier(inSection section: Int) -> String? {
        section > 0 ? ReuseIdentifiers.meaningsHeaderId : nil
    }
    
    func getReuseIdentifier(inSection section: Int) -> String {
        switch section {
        case 0:
            return ReuseIdentifiers.wordCellId
        default:
            return ReuseIdentifiers.definitionCellId
        }
    }
    
    func getWordCellViewModel() throws -> WordCellViewModel {
        guard let wordCellViewModel = wordCellViewModel else {
            throw DataError.notFound
        }

        return wordCellViewModel
    }
    
    func getMeaningsHeaderViewModel(inSection section: Int) throws
    -> MeaningsHeaderViewModel {
        guard section > 0, section <= meaningsSectionViewModels.count else {
            throw SystemError.indexOutOfRange
        }
        
        return meaningsSectionViewModels[section - 1].meaningsHeaderViewModel
    }
    
    func getDefinitionCellViewModel(forRow row: Int, inSection section: Int)
    throws -> DefinitionCellViewModel {
        guard section > 0,
              section <= meaningsSectionViewModels.count else {
            throw SystemError.indexOutOfRange
        }
        
        return try meaningsSectionViewModels[section - 1]
            .getDefinitionCellViewModel(forRow: row)
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
 
    // MARK: - Private methods
    private func loadWord(_ word: String) {
        didStartLoading?()
        wordsRepository.get(word: word)
        { [weak self] word in
            self?.updateLoadedWord(word)
            self?.didEndLoading?()
        } onFailure: { [weak self] error in
            self?.didReceiveError?(error)
            self?.didEndLoading?()
        }
    }
    
    private func updateLoadedWord(_ word: Word?) {
        clearWord()
        guard let word = word else {
            didHidePlaceholder?(false)
            didUpdateWord?()
            return
        }

        self.word = word
        wordCellViewModel = WordCellViewModel(
            word: word.word,
            phonetic: word.phonetic)
        wordCellViewModel?.delegate = self
        
        meaningsSectionViewModels = word.meanings
            .map { MeaningsSectionViewModel(meaning: $0 ) }
        
        didHidePlaceholder?(true)
        didUpdateWord?()
    }
    
    private func clearWord() {
        word = nil
        wordCellViewModel = nil
        meaningsSectionViewModels = []
    }
}

// MARK: - WordCellViewModelDelegate
extension DictionaryViewModel: WordCellViewModelDelegate {
    func didPlayAudio(withUrl audio: String) {
        audioService.playSound(audio: audio)
    }
}
