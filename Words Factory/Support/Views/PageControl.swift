import UIKit

// MARK: PageControlDelegate
protocol PageControlDelegate: AnyObject {
    func pageControl(selectedPageAt page: Int)
}

class PageControl: UIPageControl {
    
    // MARK: Properties
    override var currentPage: Int {
        didSet {
            delegate?.pageControl(selectedPageAt: currentPage)
            setupDots()
        }
    }
    
    weak var delegate: PageControlDelegate?
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        pageIndicatorTintColor = .gray
        currentPageIndicatorTintColor = .secondary
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    private func setupDots() {
        //TODO Transofrm selected dot
    }
}
