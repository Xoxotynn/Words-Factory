import Foundation
import Alamofire

class NetworkService {
    
    private let baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    // MARK: Public word methods
    func wordRequest(word: String,
                     onSuccess success: @escaping (_ word: Word) -> Void,
                     onFailure failure: @escaping (_ error: Error) -> Void) {
        AF.request(
            baseUrl + word,
            method: .get,
            encoding: JSONEncoding.default)
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                if let words = try? decoder.decode([WordDTO].self, from: data),
                   let word = WordDTO.toDomainModel(contentsOf: words) {
                    success(word)
                } else {
                    failure(NetworkError.unexpected)
                }
            case .failure(let error):
                if error.responseCode == 404 {
                    failure(NetworkError.notFound)
                    return
                }
                
                failure(NetworkError.unexpected)
            }
        }
    }
}
