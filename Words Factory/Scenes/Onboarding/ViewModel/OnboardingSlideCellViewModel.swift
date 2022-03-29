import UIKit

class OnboardingSlideCellViewModel {
    
    // MARK: Properties
    var slideImage: UIImage
    var title: String
    var description: String
    
    // MARK: Init
    init(slide: OnboardingSlide) {
        slideImage = slide.image
        title = slide.title
        description = slide.description
    }
}
