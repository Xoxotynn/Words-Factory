import UIKit

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
                image: R.image.longDistanceRelationshipKids.name,
                title: R.string.onboarding.firstTitle(),
                subtitle: R.string.onboarding.firstSubtitle())),
        OnboardingPageCellViewModel(
            topic: TopicInfo(
                image: R.image.stayingHomeKid.name,
                title: R.string.onboarding.secondTitle(),
                subtitle: R.string.onboarding.secondSubtitle())),
        OnboardingPageCellViewModel(
            topic: TopicInfo(
                image: R.image.hiTechKid.name,
                title: R.string.onboarding.thirdTitle(),
                subtitle: R.string.onboarding.thirdSubtitle()))
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
        let newTitle = page == pagesCount - 1
        ? R.string.onboarding.letsStart()
        : R.string.onboarding.next()
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
