import Foundation

struct WordDTO: Codable {
    let word: String
    let phonetics: [PhoneticDTO]
    let meanings: [MeaningDTO]
    
    static func toDomainModel(contentsOf words: [WordDTO]) -> Word? {
        guard let firstWord = words.first else {
            return nil
        }
        
        return Word(
            word: firstWord.word.capitalized,
            phonetic: PhoneticDTO
                .toDomainModel(contentsOf: words.flatMap { $0.phonetics }),
            meanings: MeaningDTO
                .toDomainModel(contentsOf: words.flatMap { $0.meanings },
                               forWord: firstWord.word.capitalized))
    }
}
