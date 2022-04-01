import UIKit
import SnapKit

class VideoViewController: UIViewController {

    // MARK: Properties
    private let viewModel: VideoViewModel
    
    private let topicView = TopicView()
    
    // MARK: Init
    init(viewModel: VideoViewModel) {
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
        viewModel.setupTopic()
        setup()
    }
    
    // MARK: Private setup methods
    private func bindToViewModel() {
        viewModel.didSetupTopicInfo = { [weak self] topicViewModel in
            self?.topicView.configure(with: topicViewModel)
        }
    }
    
    private func setup() {
        setupView()
        setupTopicView()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(topicView)
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
