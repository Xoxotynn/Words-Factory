import UIKit
import SnapKit

// MARK: Strings
private extension Strings {
    static let slideCellIdentifier = String(describing: OnboardingSlideCell.self)
}

// MARK: Dimensions
private extension Dimensions {
    static let pageControlBottomMargin: CGFloat = 72
}

class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: OnboardingViewModel
    
    private lazy var slidesCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout())
    private let pageControl = PageControl()
    private let skipButton = UIButton()
    private let nextButton = StandartButton()
    
    // MARK: Init
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        setup()
    }
    
    // MARK: Private setup methods
    private func setup() {
        setupView()
        setupSlidesCollectionView()
        setupPageControl()
        setupSkipButton()
        setupNextButton()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(slidesCollectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
    }
    
    private func setupSlidesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        slidesCollectionView.delegate = self
        slidesCollectionView.dataSource = self
        slidesCollectionView.isPagingEnabled = true
        slidesCollectionView.showsHorizontalScrollIndicator = false
        slidesCollectionView.register(
            OnboardingSlideCell.self,
            forCellWithReuseIdentifier: Strings.slideCellIdentifier)
        slidesCollectionView.setCollectionViewLayout(layout, animated: true)
        
        slidesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.bottom)
                .offset(Dimensions.standart)
            make.bottom.equalTo(pageControl.snp.top)
                .offset(-Dimensions.standart)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupPageControl() {
        pageControl.addTarget(
            self,
            action: #selector(pageControlTapped(_:)),
            for: .valueChanged)
        pageControl.numberOfPages = viewModel.slidesCount
        pageControl.currentPage = 0
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(nextButton.snp.top)
                .offset(-Dimensions.pageControlBottomMargin)
        }
    }
    
    private func setupSkipButton() {
        skipButton.titleLabel?.font = .buttonSmall
        skipButton.setTitleColor(.darkGray, for: .normal)
        skipButton.setTitle(Strings.skip, for: .normal)
        
        skipButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
        }
    }
    
    private func setupNextButton() {
        nextButton.setTitle(Strings.next, for: .normal)
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.medium)
            make.height.equalTo(Dimensions.standartButtonHeight)
        }
    }
    
    // MARK: Actions
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = CGFloat(sender.currentPage)
        var frame = slidesCollectionView.frame
        frame.origin = CGPoint(x: frame.width * page, y: 0)
        slidesCollectionView.scrollRectToVisible(frame, animated: true)
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.slidesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Strings.slideCellIdentifier,
            for: indexPath) as? OnboardingSlideCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.slideCellViewModel(at: indexPath.row))
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
