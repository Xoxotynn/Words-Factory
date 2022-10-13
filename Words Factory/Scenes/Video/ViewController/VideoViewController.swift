import UIKit
import WebKit
import SnapKit

class VideoViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: VideoViewModel
    
    private let webView = WKWebView()
    private let failedLoadTopicView = TopicView()
    
    // MARK: - Init
    init(viewModel: VideoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        failedLoadTopicView.configure(with: viewModel.failedLoadTopicViewModel)
        setup()
        viewModel.loadWebContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadWebContentIfNeeded()
    }
    
    // MARK: - Private setup methods
    private func bindToViewModel() {
        viewModel.didLoadWebContent = { [weak self] request in
            self?.webView.load(request)
            self?.toggleFailedLoadTopicView(isHidden: true)
        }
        
        viewModel.didRecieveLoadingWebContentError = { [weak self] in
            self?.toggleFailedLoadTopicView(isHidden: false)
        }
    }
    
    private func setup() {
        setupView()
        setupWebView()
        setupFailedLoadTopicView()
    }
    
    private func setupView() {
        view.backgroundColor = R.color.white()
        
        view.addSubview(webView)
        view.addSubview(failedLoadTopicView)
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupFailedLoadTopicView() {
        failedLoadTopicView.isHidden = true
        
        failedLoadTopicView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Private methods
    private func toggleFailedLoadTopicView(isHidden hidden: Bool) {
        webView.isHidden = !hidden
        failedLoadTopicView.isHidden = hidden
    }
}

// MARK: - WKNavigationDelegate
extension VideoViewController: WKNavigationDelegate {
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction)
    async -> WKNavigationActionPolicy {
        viewModel.getNavigationActionPolicy(for: navigationAction)
    }
}
