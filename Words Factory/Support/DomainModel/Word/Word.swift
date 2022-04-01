import Foundation

struct Word: Codable {
    let word: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}
