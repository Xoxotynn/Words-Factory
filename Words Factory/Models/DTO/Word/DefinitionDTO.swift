import Foundation

struct DefinitionDTO: Codable {
    let definition: String
    let example: String?
    
    func toDomainModel() -> Definition {
        Definition(definition: definition, example: example ?? "")
    }
}
