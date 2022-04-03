import UIKit

class VideoViewModel {
    
    // MARK: - Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.skateboardKid.name,
            title: R.string.localizable.notReadyTitle(),
            subtitle: R.string.localizable.notReadySubtitle()))
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
}
