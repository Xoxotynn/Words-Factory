import UIKit

// MARK: Strings
private extension Strings {
    static let firstSlideTitle = "Learn anytime\nand anywhere"
    static let firstSlideDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let secondSlideTitle = "Find a course\nfor you"
    static let secondSlideDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
    
    static let thirdSlideTitle = "\nImprove your skills"
    static let thirdSlideDescription = "Quarantine is the perfect time to spend your day learning something new, from anywhere!"
}

// MARK: Images
private extension UIImage {
    static let relationshipKids = UIImage(named: "LongDistanceRelationshipKids")
    static let stayingHomeKid = UIImage(named: "StayingHomeKid")
    static let hiTechKid = UIImage(named: "HiTechKid")
}

class OnboardingViewModel {
    
    // MARK: Properties
    private let slideCellViewModels = [
        OnboardingSlideCellViewModel(
            slide: OnboardingSlide(
                title: Strings.firstSlideTitle,
                description: Strings.firstSlideDescription,
                image: .relationshipKids ?? UIImage())),
        OnboardingSlideCellViewModel(
            slide: OnboardingSlide(
                title: Strings.secondSlideTitle,
                description: Strings.secondSlideDescription,
                image: .stayingHomeKid ?? UIImage())),
        OnboardingSlideCellViewModel(
            slide: OnboardingSlide(
                title: Strings.thirdSlideTitle,
                description: Strings.thirdSlideDescription,
                image: .hiTechKid ?? UIImage()))
    ]
    
    var currentPage: Int {
        get {
            self.currentPage
        }
        
        set(newPage) {
            self.currentPage = newPage > slidesCount - 1 ? 0 : newPage
        }
    }
    
    var slidesCount: Int {
        slideCellViewModels.count
    }
    
    // MARK: Public methods
    func slideCellViewModel(at index: Int) -> OnboardingSlideCellViewModel {
        slideCellViewModels[index]
    }
}
