import Foundation

struct Definition: Codable {
    let definition: String
    let synonyms: [String]
    let antonyms: [String]
    let example: String?
}
