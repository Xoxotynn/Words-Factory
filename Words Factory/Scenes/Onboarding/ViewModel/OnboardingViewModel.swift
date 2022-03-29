import UIKit

// MARK: Strings
private extension Strings {
    static let firstPageTitle = "Learn anytime\nand anywhere"
    static let firstPageDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let secondPageTitle = "Find a course\nfor you"
    static let secondPageDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let thirdPageTitle = "\nImprove your skills"
    static let thirdPageDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let next = "Next"
    static let start = "Let's Start"
}

// MARK: OnboardingViewModelDelegate
protocol OnboardingViewModelDelegate: AnyObject {
    func showSignUpScene()
}

// MARK: Images
private extension UIImage {
    static let relationshipKids = UIImage(named: "LongDistanceRelationshipKids")
    static let stayingHomeKid = UIImage(named: "StayingHomeKid")
    static let hiTechKid = UIImage(named: "HiTechKid")
}

class OnboardingViewModel {
    
    // MARK: Properties
    weak var delegate: OnboardingViewModelDelegate?
    
    var didChangeNextButtonTitle: ((String) -> Void)?
    
    var pagesCount: Int {
        pageCellViewModels.count
    }
    
    private let pageCellViewModels = [
        OnboardingPageCellViewModel(
            page: TopicInfo(
                title: Strings.firstPageTitle,
                description: Strings.firstPageDescription,
                image: .relationshipKids ?? UIImage())),
        OnboardingPageCellViewModel(
            page: TopicInfo(
                title: Strings.secondPageTitle,
                description: Strings.secondPageDescription,
                image: .stayingHomeKid ?? UIImage())),
        OnboardingPageCellViewModel(
            page: TopicInfo(
                title: Strings.thirdPageTitle,
                description: Strings.thirdPageDescription,
                image: .hiTechKid ?? UIImage()))
    ]
    
    // MARK: Public methods
    func getPageCellViewModel(at index: Int) -> OnboardingPageCellViewModel {
        pageCellViewModels[index]
    }
    
    func changeNextButtonTitleIfNeeded(page: Int) {
        let newTitle = page == pagesCount - 1 ? Strings.start : Strings.next
        didChangeNextButtonTitle?(newTitle)
    }
    
    func showSignUpScene() {
        delegate?.showSignUpScene()
    }
}
