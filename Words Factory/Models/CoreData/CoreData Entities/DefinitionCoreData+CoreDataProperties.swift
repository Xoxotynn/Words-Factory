import Foundation
import CoreData


extension DefinitionCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefinitionCoreData> {
        return NSFetchRequest<DefinitionCoreData>(entityName: "Definition")
    }

    @NSManaged public var example: String?
    @NSManaged public var definition: String?
    @NSManaged public var meaning: MeaningCoreData?

}

extension DefinitionCoreData : Identifiable {

}
