import Foundation

class WordsDataRepository: WordsRepository {
    
    // MARK: Properties
    private let remoteDataSource: WordsDataSource
    private let localDataSource: WordsDataSource
    
    // MARK: Init
    init(remoteDataSource: WordsDataSource,
         localDataSource: WordsDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    // MARK: Public methods
    func getWord(word: String,
                 onSuccess success: @escaping (Word) -> Void,
                 onFailure failure: @escaping (Error) -> Void) {
        localDataSource.getWord(word: word)
        { word in
            success(word)
        } onFailure: { [weak self] error in
            self?.remoteDataSource.getWord(word: word)
            { word in
                success(word)
            } onFailure: { error in
                failure(error)
            }

        }

    }
}
