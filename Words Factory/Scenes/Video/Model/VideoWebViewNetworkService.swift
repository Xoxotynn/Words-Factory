import Foundation
import Alamofire
import WebKit

class VideoWebViewNetworkService {
    
    // MARK: - Properties
    var isConnected: Bool {
        reachibilityManager?.isReachable ?? false
    }
    
    var baseUrlRequest: URLRequest? {
        guard let baseUrl = baseUrl else {
            return nil
        }
        
        return URLRequest(url: baseUrl)
    }
    
    private let baseUrlAbsolutePath = "https://learnenglish.britishcouncil.org/general-english/video-zone"
    private let baseUrl: URL?
    private let reachibilityManager: NetworkReachabilityManager?
    
    
    // MARK: - Init
    init() {
        baseUrl = URL(string: baseUrlAbsolutePath)
        reachibilityManager = NetworkReachabilityManager(
            host: baseUrl?.host ?? "")
    }
    
    // MARK: - Public methods
    func getNavigationActionPolicy(forAbsolutePath path: String)
    -> WKNavigationActionPolicy {
        guard path.starts(with: baseUrlAbsolutePath) else {
            return .cancel
        }
        
        return .allow
    }
}
