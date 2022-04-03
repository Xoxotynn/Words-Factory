import Foundation

protocol WordsDataSource {
    func get(word: String,
             onSuccess success: @escaping (_ word: Word) -> Void,
             onFailure failure: @escaping (_ error: Error) -> Void)
    func add(domainWord: Word,
             onSuccess success: @escaping (_ word: Word) -> Void,
             onFailure failure: @escaping (_ error: Error) -> Void)
}
