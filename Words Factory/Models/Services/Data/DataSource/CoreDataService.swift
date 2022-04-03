import Foundation
import CoreData

class CoreDataService: WordsDataSource {
    
    // MARK: - Properties
    private static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WordsDatabase")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(String(describing: error))
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        Self.container.viewContext
    }
    
    // MARK: - Public methods
    func get(word: String,
             onSuccess success: @escaping (Word) -> Void,
             onFailure failure: @escaping (Error) -> Void) {
        guard let wordCoreData = WordCoreData.get(word: word, context: context),
              let wordDomain = wordCoreData.toDomainModel() else {
            failure(DataError.notFound)
            return
        }
        
        success(wordDomain)
    }
    
    func add(domainWord: Word,
             onSuccess success: @escaping (_ word: Word) -> Void,
             onFailure failure: @escaping (_ error: Error) -> Void) {
        let word = WordCoreData.addOrUpdate(domainWord: domainWord, context: context)
        saveContext()
        
        guard let addedWord = word.toDomainModel() else {
            failure(DataError.creationFailed)
            return
        }
        success(addedWord)
    }
    
    // MARK: - Private Methods
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                fatalError(String(describing: error))
            }
        }
    }
}
