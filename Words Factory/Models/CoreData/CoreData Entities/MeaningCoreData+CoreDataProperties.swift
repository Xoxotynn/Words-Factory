import Foundation
import CoreData


extension MeaningCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningCoreData> {
        return NSFetchRequest<MeaningCoreData>(entityName: "Meaning")
    }

    @NSManaged public var speechPart: String?
    @NSManaged public var definitions: NSSet?
    @NSManaged public var word: WordCoreData?

}

// MARK: Generated accessors for definitions
extension MeaningCoreData {

    @objc(addDefinitionsObject:)
    @NSManaged public func addToDefinitions(_ value: DefinitionCoreData)

    @objc(removeDefinitionsObject:)
    @NSManaged public func removeFromDefinitions(_ value: DefinitionCoreData)

    @objc(addDefinitions:)
    @NSManaged public func addToDefinitions(_ values: NSSet)

    @objc(removeDefinitions:)
    @NSManaged public func removeFromDefinitions(_ values: NSSet)

}

extension MeaningCoreData : Identifiable {

}
