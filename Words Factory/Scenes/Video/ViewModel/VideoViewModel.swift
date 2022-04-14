import UIKit

class VideoViewModel {
    
    // MARK: - Properties
    let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: R.image.skateboardKid.name,
            title: R.string.localizable.notReadyTitle(),
            subtitle: R.string.localizable.notReadySubtitle()))
}
