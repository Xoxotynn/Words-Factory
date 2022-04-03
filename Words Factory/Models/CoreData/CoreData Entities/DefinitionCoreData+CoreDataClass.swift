import Foundation
import CoreData


public class DefinitionCoreData: NSManagedObject {
    
    // MARK: Public methods
    static func getOrAdd(domainDefinition: Definition,
                         context: NSManagedObjectContext)
    -> DefinitionCoreData {
        let request = DefinitionCoreData.fetchRequest()
        let definitionPredicate = NSPredicate(
            format: "%K == %@", "definition", domainDefinition.definition)
        let examplePredicate = NSPredicate(
            format: "%K == %@", "example", domainDefinition.example)
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                definitionPredicate,
                examplePredicate
            ])
        
        guard let definitionCoreData = try? context.fetch(request).first else {
            return DefinitionCoreData.add(
                domainDefinition: domainDefinition,
                context: context)
        }
        
        return definitionCoreData
    }
    
    func toDomainModel() -> Definition {
        Definition(definition: definition ?? "",
                   example: example ?? "")
    }
    
    // MARK: Private methods
    private static func add(domainDefinition: Definition,
                            context: NSManagedObjectContext)
    -> DefinitionCoreData {
        let definitionCoreData = DefinitionCoreData(context: context)
        definitionCoreData.update(with: domainDefinition, context: context)
        return definitionCoreData
    }
    
    private func update(with domainDefinition: Definition,
                        context: NSManagedObjectContext) {
        definition = domainDefinition.definition
        example = domainDefinition.example
    }
}
