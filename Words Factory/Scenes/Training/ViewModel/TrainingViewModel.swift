import UIKit

class TrainingViewModel {
    
    // MARK: - Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.hiTechKid.name,
            title: Strings.sceneNotReadyTitle,
            subtitle: Strings.sceneNotReadySubtitle))
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
}
