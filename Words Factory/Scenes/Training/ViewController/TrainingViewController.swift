import UIKit
import SnapKit

class TrainingViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: TrainingViewModel
    
    private let topicView = TopicView()
    
    // MARK: - Init
    init(viewModel: TrainingViewModel) {
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
        topicView.configure(with: viewModel.topicViewModel)
        setup()
    }
    
    // MARK: - Private setup methods
    private func bindToViewModel() {
        
    }
    
    private func setup() {
        setupView()
        setupTopicView()
    }
    
    private func setupView() {
        view.backgroundColor = R.color.white()
        
        view.addSubview(topicView)
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
