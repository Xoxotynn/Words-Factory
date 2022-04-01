import UIKit
import SnapKit

// MARK: Strings
private extension Strings {
    static let skip = "Skip"
    static let pageCellIdentifier = String(describing: OnboardingPageCell.self)
}

// MARK: Dimensions
private extension Dimensions {
    static let pageControlBottomMargin: CGFloat = 72
}

class OnboardingViewController: UIViewController {
    
    // MARK: Properties
    private let viewModel: OnboardingViewModel
    
    private let pagesCollectionView = UICollectionView(
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
        super.viewDidLoad()
        bindToViewModel()
        setup()
    }
    
    // MARK: Private setup methods
    private func bindToViewModel() {
        viewModel.didChangeNextButtonTitle = { [weak self] title in
            self?.nextButton.setTitle(title, for: .normal)
        }
        
        viewModel.didChangePage = { [weak self] page in
            self?.scrollToPage(at: page)
        }
    }
    
    private func setup() {
        setupView()
        setupPagesCollectionView()
        setupPageControl()
        setupSkipButton()
        setupNextButton()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(pagesCollectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
    }
    
    private func setupPagesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        pagesCollectionView.delegate = self
        pagesCollectionView.dataSource = self
        pagesCollectionView.isPagingEnabled = true
        pagesCollectionView.showsHorizontalScrollIndicator = false
        pagesCollectionView.register(
            OnboardingPageCell.self,
            forCellWithReuseIdentifier: Strings.pageCellIdentifier)
        pagesCollectionView.setCollectionViewLayout(layout, animated: true)
        
        pagesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.bottom)
                .offset(Dimensions.standart)
            make.bottom.equalTo(pageControl.snp.top)
                .offset(-Dimensions.standart)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupPageControl() {
        pageControl.delegate = self
        pageControl.addTarget(
            self,
            action: #selector(pageControlTapped(_:)),
            for: .valueChanged)
        pageControl.numberOfPages = viewModel.pagesCount
        pageControl.currentPage = 0
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(nextButton.snp.top)
                .offset(-Dimensions.pageControlBottomMargin)
        }
    }
    
    private func setupSkipButton() {
        skipButton.addTarget(
            self,
            action: #selector(skipOnboarding),
            for: .touchUpInside)
        skipButton.titleLabel?.font = .buttonSmall
        skipButton.setTitleColor(.darkGray, for: .normal)
        skipButton.setTitle(Strings.skip, for: .normal)
        
        skipButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
        }
    }
    
    private func setupNextButton() {
        nextButton.addTarget(
            self,
            action: #selector(showNextPage),
            for: .touchUpInside)
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.medium)
            make.height.equalTo(Dimensions.standartButtonHeight)
        }
    }
    
    // MARK: Private methods
    private func scrollToPage(at page: Int) {
        var frame = pagesCollectionView.frame
        frame.origin = CGPoint(x: frame.width * CGFloat(page), y: 0)
        pagesCollectionView.scrollRectToVisible(frame, animated: true)
        pageControl.currentPage = page
    }
    
    // MARK: Actions
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        viewModel.showPage(at: sender.currentPage)
    }
    
    @objc private func showNextPage() {
        viewModel.showPage(at: pageControl.currentPage + 1)
    }
    
    @objc private func skipOnboarding() {
        viewModel.showSignUpScene()
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension OnboardingViewController:
    UICollectionViewDelegate & UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.pagesCount
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Strings.pageCellIdentifier,
                for: indexPath) as? OnboardingPageCell else {
                return UICollectionViewCell()
            }
            
            do {
                try cell.configure(with: viewModel
                    .getPageCellViewModel(at: indexPath.row))
            } catch {
                showError(error)
            }
            
            return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x /
                                      scrollView.frame.width)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.frame.size
    }
}

// MARK: PageControlDelegate
extension OnboardingViewController: PageControlDelegate {
    func pageControl(selectedPageAt page: Int) {
        viewModel.changeNextButtonTitleIfNeeded(page: page)
    }
}
