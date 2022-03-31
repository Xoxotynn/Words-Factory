import UIKit

class OnboardingPageCellViewModel {
    
    // MARK: Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel: TopicViewModel
    
    // MARK: Init
    init(topic: TopicInfo) {
        topicViewModel = TopicViewModel(topic: topic)
    }
    
    // MARK: Public methods
    func setupTopicInfo() {
        didSetupTopicInfo?(topicViewModel)
        topicViewModel.updateTopicInfo()
    }
}
