import UIKit

class TrainingViewModel {
    
    // MARK: - Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.hiTechKid.name,
            title: R.string.localizable.notReadyTitle(),
            subtitle: R.string.localizable.notReadySubtitle()))
    
    // MARK: - Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
}
