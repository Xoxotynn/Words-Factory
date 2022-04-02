import Foundation

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}
