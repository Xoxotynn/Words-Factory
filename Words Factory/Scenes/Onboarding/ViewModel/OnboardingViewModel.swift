import UIKit

// MARK: - Strings
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

// MARK: - OnboardingViewModelDelegate
protocol OnboardingViewModelDelegate: AnyObject {
    func showSignUpScene()
}

class OnboardingViewModel {
    
    // MARK: - Properties
    weak var delegate: OnboardingViewModelDelegate?
    
    var didChangeNextButtonTitle: ((String) -> Void)?
    var didChangePage: ((Int) -> Void)?
    
    var pagesCount: Int {
        pageCellViewModels.count
    }
    
    private let pageCellViewModels = [
        OnboardingPageCellViewModel(
            topic: TopicInfo(
                image: Images.relationshipKids,
                title: Strings.firstPageTitle,
                subtitle: Strings.firstPageDescription)),
        OnboardingPageCellViewModel(
            topic: TopicInfo(
                image: Images.stayingHomeKid,
                title: Strings.secondPageTitle,
                subtitle: Strings.secondPageDescription)),
        OnboardingPageCellViewModel(
            topic: TopicInfo(
                image: Images.hiTechKid,
                title: Strings.thirdPageTitle,
                subtitle: Strings.thirdPageDescription))
    ]
    
    // MARK: - Public methods
    func getPageCellViewModel(at index: Int) throws
    -> OnboardingPageCellViewModel {
        guard index >= 0 && index < pagesCount else {
            throw SystemError.indexOutOfRange
        }
        
        return pageCellViewModels[index]
    }
    
    func changeNextButtonTitleIfNeeded(page: Int) {
        let newTitle = page == pagesCount - 1 ? Strings.start : Strings.next
        didChangeNextButtonTitle?(newTitle)
    }
    
    func showPage(at page: Int) {
        guard page < pagesCount else {
            delegate?.showSignUpScene()
            return
        }
        
        didChangePage?(page)
    }
    
    func showSignUpScene() {
        delegate?.showSignUpScene()
    }
}
