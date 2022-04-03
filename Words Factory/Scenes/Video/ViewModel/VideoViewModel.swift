import UIKit

class VideoViewModel {
    
    // MARK: - Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.skateboardKid.name,
            title: Strings.sceneNotReadyTitle,
            subtitle: Strings.sceneNotReadySubtitle))
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
}
