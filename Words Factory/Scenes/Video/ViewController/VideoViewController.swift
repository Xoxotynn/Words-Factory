import UIKit

class VideoViewController: UIViewController {

    // MARK: Properties
    private let viewModel: VideoViewModel
    
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
        setup()
    }
    
    // MARK: Private setup methods
    private func setup() {
        view.backgroundColor = .appWhite
    }
}
