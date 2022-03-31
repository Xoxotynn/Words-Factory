import UIKit
import SnapKit

// MARK: Strings
private extension Strings {
    static let namePlaceholder = "Name"
    static let emailPlaceholder = "E-mail"
    static let passwordPlaceholder = "Password"
}

// MARK: Dimensions
private extension Dimensions {
    static let topScreenMargin: CGFloat = 58
    static let bottomScreenMaxMargin: CGFloat = 67
    static let textFieldHeight: CGFloat = 53
}

class SignUpViewController: UIViewController {

    // MARK: Properties
    private let viewModel: SignUpViewModel
    
    private let topicView = TopicView()
    private let signUpFormStack = UIStackView()
    private let nameTextField = TextField()
    private let emailTextField = TextField()
    private let passwordTextField = PasswordTextField()
    private let signUpButton = StandartButton()
    
    // MARK: Init
    init(viewModel: SignUpViewModel) {
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
        
        viewModel.didRecieveErrors = { [weak self] errors in
            self?.showMultipleErrors(errors)
        }
    }
    
    private func setup() {
        setupView()
        setupTopicView()
        setupSignUpFormStack()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(topicView)
        view.addSubview(signUpFormStack)
        signUpFormStack.addArrangedSubview(nameTextField)
        signUpFormStack.addArrangedSubview(emailTextField)
        signUpFormStack.addArrangedSubview(passwordTextField)
        signUpFormStack.addArrangedSubview(signUpButton)
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
                .priority(.high)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.topScreenMargin)
            make.bottom.equalTo(signUpFormStack.snp.top)
                .offset(-Dimensions.standart)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupSignUpFormStack() {
        signUpFormStack.axis = .vertical
        signUpFormStack.spacing = Dimensions.standart
        
        signUpFormStack.snp.makeConstraints { make in
            make.bottom.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
                .priority(.medium)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.bottomScreenMaxMargin)
                .priority(.high)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
        }
    }
    
    private func setupNameTextField() {
        nameTextField.textContentType = .name
        nameTextField.setPlaceholder(Strings.namePlaceholder)
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.textFieldHeight)
        }
    }
    
    private func setupEmailTextField() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textContentType = .emailAddress
        emailTextField.setPlaceholder(Strings.emailPlaceholder)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.textFieldHeight)
        }
    }
    
    private func setupPasswordTextField() {
        passwordTextField.setPlaceholder(Strings.passwordPlaceholder)
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.textFieldHeight)
        }
    }
    
    // MARK: Private methods
    private func setupSignUpButton() {
        signUpButton.addTarget(
            self,
            action: #selector(signUp),
            for: .touchUpInside)
        signUpButton.setTitle(Strings.signUp, for: .normal)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.standartButtonHeight)
        }
    }
    
    // MARK: Actions
    @objc private func signUp() {
        viewModel.signUp(
            name: nameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text)
    }
}
