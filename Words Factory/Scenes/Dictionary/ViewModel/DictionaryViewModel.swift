import UIKit

// MARK: Strings
extension Strings {
    static let noWordTitle = "No word"
    static let noWordSubtitle = "Input something to find it in dictionary"
}

class DictionaryViewModel {
    
    // MARK: Properties
    var didSetupTopicInfo: ((TopicViewModel) -> Void)?
    
    private let topicViewModel = TopicViewModel(
        topic: TopicInfo(
            image: .standingKid ?? UIImage(),
            title: Strings.noWordTitle,
            subtitle: Strings.noWordSubtitle))
    
    // MARK: Public methods
    func setupTopic() {
        didSetupTopicInfo?(topicViewModel)
    }
}
