import UIKit

class OnboardingPageCellViewModel {
    
    // MARK: Properties
    var didUpdatePageInfo: ((TopicInfo) -> Void)?
    
    private let page: TopicInfo
    
    // MARK: Init
    init(page: TopicInfo) {
        self.page = page
    }
    
    // MARK: Public methods
    func setup() {
        didUpdatePageInfo?(page)
    }
}
