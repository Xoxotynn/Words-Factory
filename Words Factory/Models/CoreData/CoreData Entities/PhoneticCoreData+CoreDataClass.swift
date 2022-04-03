import Foundation
import CoreData


public class PhoneticCoreData: NSManagedObject {

    // MARK: - Public methods
    static func getOrAdd(domainPhonetic: Phonetic,
                         context: NSManagedObjectContext) -> PhoneticCoreData {
        let request = PhoneticCoreData.fetchRequest()
        let textPredicate = NSPredicate(
            format: "%K == %@", "text", domainPhonetic.text)
        let audioPredicate = NSPredicate(
            format: "%K == %@", "audio", domainPhonetic.audio)
        request.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [
                textPredicate,
                audioPredicate
            ])
        
        guard let phoneticCoreData = try? context.fetch(request).first else {
            return PhoneticCoreData.add(domainPhonetic: domainPhonetic,
                                        context: context)
        }
        
        return phoneticCoreData
    }
    
    func toDomainModel() -> Phonetic {
        Phonetic(text: text ?? "",
                 audio: audio ?? "")
    }
    
    // MARK: - Private methods
    private static func add(domainPhonetic: Phonetic,
                            context: NSManagedObjectContext) -> PhoneticCoreData {
        let phoneticCoreData = PhoneticCoreData(context: context)
        phoneticCoreData.update(with: domainPhonetic, context: context)
        return phoneticCoreData
    }
    
    private func update(with domainPhonetic: Phonetic,
                        context: NSManagedObjectContext) {
        text = domainPhonetic.text
        audio = domainPhonetic.audio
    }
}
