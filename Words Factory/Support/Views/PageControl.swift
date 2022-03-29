import UIKit

// MARK: Images
private extension UIImage {
    static let selectedDotIcon = UIImage(named: "SelectedDotIcon")
    static let dotIcon = UIImage(named: "DotIcon")
}

// MARK: PageControlDelegate
protocol PageControlDelegate: AnyObject {
    func pageControl(selectedPageAt page: Int)
}

class PageControl: UIPageControl {
    
    // MARK: Properties
    override var numberOfPages: Int {
        didSet {
            setupDots()
        }
    }
    
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
        if #available(iOS 14.0, *) {
            allowsContinuousInteraction = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        delegate?.pageControl(selectedPageAt: currentPage)
        setupDots()
    }
    
    // MARK: Private methods
    private func setupDots() {
        let dots = getDots()
        
        for (index, dot) in dots.enumerated() {
            let dotImageView: UIImageView
            
            if let existingImageView = getImageView(forSubview: dot) {
                dotImageView = existingImageView
            } else {
                dotImageView = UIImageView(image: .dotIcon)
                dotImageView.center = dot.center
                dot.addSubview(dotImageView)
                dot.clipsToBounds = false
            }
            
            if currentPage == index {
                UIView.animate(withDuration: 0.2) {
                    dotImageView.image = .selectedDotIcon
                }
            } else {
                dotImageView.image = .dotIcon
            }
        }
    }
    
    private func getDots() -> [UIView] {
        var dotViews: [UIView] = subviews
        if #available(iOS 14, *) {
            let pageControl = dotViews[0]
            let dotContainerView = pageControl.subviews[0]
            dotViews = dotContainerView.subviews
        }
        
        return dotViews
    }
    
    private func getImageView(forSubview view: UIView) -> UIImageView? {
        if let imageView = view as? UIImageView {
            return imageView
        }
        
        return view.subviews.first { view in
            view is UIImageView
        } as? UIImageView
    }
}
