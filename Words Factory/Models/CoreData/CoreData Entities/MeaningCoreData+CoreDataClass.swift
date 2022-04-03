import Foundation
import CoreData


public class MeaningCoreData: NSManagedObject {

    // MARK: Public methods
    static func getOrAdd(domainMeaning: Meaning,
                         context: NSManagedObjectContext) -> MeaningCoreData {
        let request = MeaningCoreData.fetchRequest()
        let speechPartPredicate = NSPredicate(
            format: "speechPart == \"\(domainMeaning.speechPart)\"")
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                speechPartPredicate
            ])
        
        guard let meaningCoreData = try? context.fetch(request).first(
            where: { meaning in
                meaning.word?.word == domainMeaning.word
            }) else {
                return MeaningCoreData.add(domainMeaning: domainMeaning,
                                           context: context)
            }
        
        meaningCoreData.update(with: domainMeaning, context: context)
        return meaningCoreData
    }
    
    func toDomainModel() -> Meaning? {
        guard let domainDefinitions = definitions?
            .compactMap({ definition in
                (definition as? DefinitionCoreData)?.toDomainModel()
            }) else { return nil }
        
        return Meaning(word: word?.word ?? "",
                       speechPart: speechPart ?? "",
                       definitions: domainDefinitions)
    }
    
    // MARK: Private methods
    private static func add(domainMeaning: Meaning,
                            context: NSManagedObjectContext) -> MeaningCoreData {
        let meaningCoreData = MeaningCoreData(context: context)
        meaningCoreData.update(with: domainMeaning, context: context)
        return meaningCoreData
    }
    
    private func update(with domainMeaning: Meaning,
                        context: NSManagedObjectContext) {
        speechPart = domainMeaning.speechPart
        definitions = NSSet(
            array: domainMeaning.definitions.map { definition in
                DefinitionCoreData.getOrAdd(domainDefinition: definition,
                                            context: context)
            })
    }
}
