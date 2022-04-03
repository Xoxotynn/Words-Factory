import Foundation

struct PhoneticDTO: Codable {
    
    // MARK: - Properties
    let text: String?
    let audio: String?
    
    // MARK: - Public methods
    static func toDomainModel(contentsOf phonetics: [PhoneticDTO]) -> Phonetic {
        let text = phonetics
            .first(where: { !($0.text?.isEmpty ?? true) })?.text ?? ""
        let audio = phonetics
            .first(where: { !($0.audio?.isEmpty ?? true) })?.audio ?? ""
        
        return Phonetic(text: text, audio: audio)
    }
}
