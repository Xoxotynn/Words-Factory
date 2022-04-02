import Foundation

class WordCellViewModel {
    
    // MARK: Properties
    let word: String
    let phoneticText: String?
    
    var didSetupWord: (() -> Void)?
    
    private let phonetic: Phonetic
    
    // MARK: Init
    init(word: String, phonetic: Phonetic) {
        self.word = word.capitalized
        self.phonetic = phonetic
        phoneticText = phonetic.text
    }
    
    // MARK: Public methods
    func setupWord() {
        didSetupWord?()
    }
}
