import UIKit

class TrainingViewModel {
    
    // MARK: - Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: Images.hiTechKid,
            title: Strings.sceneNotReadyTitle,
            subtitle: Strings.sceneNotReadySubtitle))
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
}
