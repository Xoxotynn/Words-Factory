import Foundation
import CoreData


extension PhoneticCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneticCoreData> {
        return NSFetchRequest<PhoneticCoreData>(entityName: "Phonetic")
    }

    @NSManaged public var text: String?
    @NSManaged public var audio: String?
    @NSManaged public var word: WordCoreData?

}

extension PhoneticCoreData : Identifiable {

}
