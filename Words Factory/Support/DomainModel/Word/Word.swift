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
        
        let phonetics = words.flatMap { $0.phonetics }
        let meanings = words.flatMap { $0.meanings }
        let speechParts = Set(meanings.map { $0.partOfSpeech })
        
        return Word(
            word: firstWord.word,
            phonetics: [reduce(contentsOf: phonetics)],
            meanings: speechParts.map { speechPart in
                reduce(contentsOf: meanings, withSpeechPart: speechPart)
            })
    }
    
    private static func reduce(
        contentsOf meanings: [Meaning],
        withSpeechPart speechPart: String) -> Meaning {
            return Meaning(
                partOfSpeech: speechPart,
                definitions: meanings
                    .filter { $0.partOfSpeech == speechPart }
                    .flatMap { $0.definitions })
        }
    
    private static func reduce(contentsOf phonetics: [Phonetic]) -> Phonetic {
        let text = phonetics
            .first(where: { !($0.text?.isEmpty ?? true) })?.text ?? ""
        let audio = phonetics
            .first(where: { !($0.audio?.isEmpty ?? true) })?.audio ?? ""
        
        return Phonetic(text: text, audio: audio)
    }
}
