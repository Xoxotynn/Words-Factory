import Foundation

struct DefinitionDTO: Codable {
    
    // MARK: - Properties
    let definition: String
    let example: String?
    
    // MARK: - Public methods
    func toDomainModel() -> Definition {
        Definition(definition: definition, example: example ?? "")
    }
}
