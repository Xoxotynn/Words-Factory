import Foundation

// MARK: - WordCellViewModelDelegate
protocol WordCellViewModelDelegate: AnyObject {
    func didPlayAudio(withUrl audio: String)
}

class WordCellViewModel {
    
    // MARK: - Properties
    let word: String
    let phoneticText: String?
    
    weak var delegate: WordCellViewModelDelegate?
    
    var didSetupWord: (() -> Void)?
    
    private let phonetic: Phonetic
    
    // MARK: - Init
    init(word: String, phonetic: Phonetic) {
        self.word = word
        self.phonetic = phonetic
        phoneticText = phonetic.text
    }
    
    // MARK: - Public methods
    func setupWord() {
        didSetupWord?()
    }
    
    func playAudio() {
        if !phonetic.audio.isEmpty {
            delegate?.didPlayAudio(withUrl: phonetic.audio)
        }
    }
}
