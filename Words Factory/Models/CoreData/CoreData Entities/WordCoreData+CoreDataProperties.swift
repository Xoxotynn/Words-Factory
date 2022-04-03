import Foundation
import CoreData


extension WordCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordCoreData> {
        return NSFetchRequest<WordCoreData>(entityName: "Word")
    }

    @NSManaged public var word: String?
    @NSManaged public var meanings: NSSet?
    @NSManaged public var phonetic: PhoneticCoreData?

}

// MARK: Generated accessors for meanings
extension WordCoreData {

    @objc(addMeaningsObject:)
    @NSManaged public func addToMeanings(_ value: MeaningCoreData)

    @objc(removeMeaningsObject:)
    @NSManaged public func removeFromMeanings(_ value: MeaningCoreData)

    @objc(addMeanings:)
    @NSManaged public func addToMeanings(_ values: NSSet)

    @objc(removeMeanings:)
    @NSManaged public func removeFromMeanings(_ values: NSSet)

}

extension WordCoreData : Identifiable {

}
