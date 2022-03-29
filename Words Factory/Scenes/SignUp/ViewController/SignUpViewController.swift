import UIKit

class SignUpViewController: UIViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
    }
}
