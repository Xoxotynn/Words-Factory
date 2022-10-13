import UIKit
import WebKit

class VideoViewModel {
    
    // MARK: - Properties
    var didLoadWebContent: ((URLRequest) -> Void)?
    var didRecieveLoadingWebContentError: (() -> Void)?
    
    let failedLoadTopicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.skateboardKid.name,
            title: R.string.video.loadingFailureTitle(),
            subtitle: R.string.video.loadingFailureSubtitle()))
    
    private let videoWebViewNetworkService: VideoWebViewNetworkService
    
    private var isFailedLoading: Bool
    
    // MARK: - Init
    init(videoService: VideoWebViewNetworkService) {
        videoWebViewNetworkService = videoService
        isFailedLoading = false
    }
    
    // MARK: - Public methods
    func loadWebContentIfNeeded() {
        if isFailedLoading {
            loadWebContent()
        }
    }
    
    func loadWebContent() {
        guard let request = videoWebViewNetworkService.baseUrlRequest,
              videoWebViewNetworkService.isConnected else {
            isFailedLoading = true
            didRecieveLoadingWebContentError?()
            return
        }
        
        isFailedLoading = false
        didLoadWebContent?(request)
    }
    
    func getNavigationActionPolicy(for navigationAction: WKNavigationAction)
    -> WKNavigationActionPolicy {
        guard navigationAction.navigationType == .linkActivated else {
            return .allow
        }
        
        guard let path = navigationAction.request.url?.absoluteString else {
            return .cancel
        }

        return videoWebViewNetworkService.getNavigationActionPolicy(
            forAbsolutePath: path)
    }
}
