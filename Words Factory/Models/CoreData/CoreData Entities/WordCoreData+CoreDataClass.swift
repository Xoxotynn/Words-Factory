import Foundation
import CoreData


public class WordCoreData: NSManagedObject {

    // MARK: - Public methods
    static func get(word: String,
                    context: NSManagedObjectContext) -> WordCoreData? {
        let request = WordCoreData.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", "word", word)
        return try? context.fetch(request).first
    }
    
    static func addOrUpdate(domainWord: Word,
                            context: NSManagedObjectContext) -> WordCoreData {
        let request = WordCoreData.fetchRequest()
        request.predicate = NSPredicate(
            format: "%K == %@", "word", domainWord.word)
        
        guard let wordCoreData = get(word: domainWord.word,
                                     context: context) else {
            return WordCoreData.add(domainWord: domainWord,
                                    context: context)
        }
        
        wordCoreData.update(with: domainWord, context: context)
        return wordCoreData
    }
    
    func toDomainModel() -> Word? {
        guard let phoneticDomain = phonetic?.toDomainModel(),
              let meaningsDomain = meanings?.compactMap({ meaning in
                  (meaning as? MeaningCoreData)?.toDomainModel()
              }) else { return nil }
        
        return Word(word: word ?? "",
                    phonetic: phoneticDomain,
                    meanings: meaningsDomain)
    }
    
    // MARK: - Private methods
    private static func add(domainWord: Word,
                            context: NSManagedObjectContext) -> WordCoreData {
        let wordCoreData = WordCoreData(context: context)
        wordCoreData.update(with: domainWord, context: context)
        return wordCoreData
    }
    
    private func update(with domainWord: Word,
                        context: NSManagedObjectContext) {
        word = domainWord.word
        phonetic = PhoneticCoreData.getOrAdd(
            domainPhonetic: domainWord.phonetic,
            context: context)
        meanings = NSSet(array: domainWord.meanings.map { meaning in
            MeaningCoreData.getOrAdd(domainMeaning: meaning,
                                     context: context)
        })
    }
}
