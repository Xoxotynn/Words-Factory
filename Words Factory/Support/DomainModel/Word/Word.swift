import Foundation

struct Word: Codable {
    let word: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}

extension Word {
    static func reduce(contentsOf words: [Word]) -> Word? {
        guard let firstWord = words.first else {
            return nil
        }
        
        var meanings = firstWord.meanings
        words.forEach { meanings.append(contentsOf: $0.meanings) }
        return Word(
            word: firstWord.word,
            phonetics: firstWord.phonetics,
            meanings: meanings)
    }
}
