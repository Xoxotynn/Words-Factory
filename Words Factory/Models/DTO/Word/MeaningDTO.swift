import Foundation

struct MeaningDTO: Codable {
    let partOfSpeech: String
    let definitions: [DefinitionDTO]
    
    static func toDomainModel(contentsOf meanings: [MeaningDTO]) -> [Meaning] {
        let speechParts = Set(meanings.map { $0.partOfSpeech })
        
        return speechParts.map { speechPart in
            Meaning(speechPart: speechPart,
                    definitions: meanings
                .filter { $0.partOfSpeech == speechPart }
                .flatMap { $0.definitions }
                .map { $0.toDomainModel() })
        }
    }
}
