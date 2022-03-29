import UIKit

// MARK: Strings
private extension Strings {
    static let firstPageTitle = "Learn anytime\nand anywhere"
    static let firstPageDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let secondPageTitle = "Find a course\nfor you"
    static let secondPageDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let thirdPageTitle = "\nImprove your skills"
    static let thirdPageDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
}

// MARK: Images
private extension UIImage {
    static let relationshipKids = UIImage(named: "LongDistanceRelationshipKids")
    static let stayingHomeKid = UIImage(named: "StayingHomeKid")
    static let hiTechKid = UIImage(named: "HiTechKid")
}

class OnboardingViewModel {
    
    // MARK: Properties
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
    
    var pagesCount: Int {
        pageCellViewModels.count
    }
    
    // MARK: Public methods
    func getPageCellViewModel(at index: Int) -> OnboardingPageCellViewModel {
        pageCellViewModels[index]
    }
}
