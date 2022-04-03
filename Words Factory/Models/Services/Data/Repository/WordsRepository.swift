import Foundation

protocol WordsRepository {
    func getWord(
        word: String,
        onSuccess success: @escaping (_ word: Word) -> Void,
        onFailure failure: @escaping (_ error: Error) -> Void)
}
