import Foundation

class WordsDataRepository: WordsRepository {
    
    // MARK: - Properties
    private let remoteDataSource: WordsDataSource
    private let localDataSource: WordsDataSource
    
    // MARK: - Init
    init(remoteDataSource: WordsDataSource,
         localDataSource: WordsDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    // MARK: - Public methods
    func get(word: String,
             onSuccess success: @escaping (Word) -> Void,
             onFailure failure: @escaping (Error) -> Void) {
        remoteDataSource.get(word: word)
        { word in
            success(word)
        } onFailure: { [weak self] error in
            self?.localDataSource.get(word: word)
            { word in
                success(word)
            } onFailure: { error in
                failure(error)
            }

        }

    }
    
    func add(domainWord: Word,
             onSuccess success: @escaping (_ word: Word) -> Void,
             onFailure failure: @escaping (_ error: Error) -> Void) {
        localDataSource.add(domainWord: domainWord)
        { word in
            success(word)
        } onFailure: { error in
            failure(error)
        }

    }
}
