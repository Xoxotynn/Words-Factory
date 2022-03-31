import Foundation

final class TopicViewModel {
    
    // MARK: Properties
    var didUpdateTopicInfo: ((TopicInfo) -> Void)?
    
    private let topic: TopicInfo
    
    // MARK: Init
    init(topic: TopicInfo) {
        self.topic = topic
    }
    
    // MARK: Public methods
    func updateTopicInfo() {
        didUpdateTopicInfo?(topic)
    }
}
