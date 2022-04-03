import Foundation
import CoreData

class CoreDataService: WordsDataSource {
    
    // MARK: Properties
    private let context: NSManagedObjectContext
    
    // MARK: Init
    init() {
        let container = NSPersistentContainer(name: "WordsDatabase")
        container.loadPersistentStores { _, error in
            if let error = error {
                print(String(describing: error))
            }
        }
        context = container.newBackgroundContext()
    }
    
    // MARK: Public methods
    func getWord(word: String,
                 onSuccess success: @escaping (Word) -> Void,
                 onFailure failure: @escaping (Error) -> Void) {
        failure(NetworkError.notFound)
    }
    
    // MARK: Private Methods
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
