import Foundation
import Alamofire

class NetworkService {
    
    private let baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    // MARK: Public word methods
    func signUpRequest(word: String,
                       onSuccess success: @escaping (_ words: [Word]) -> Void,
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
                if let words = try? decoder.decode([Word].self, from: data) {
                    success(words)
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
