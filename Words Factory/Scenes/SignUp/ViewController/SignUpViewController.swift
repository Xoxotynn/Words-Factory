import UIKit
import SnapKit
import TPKeyboardAvoidingSwift

// MARK: - Dimensions
private extension Dimensions {
    static let topScreenMargin: CGFloat = 58
    static let bottomScreenMaxMargin: CGFloat = 67
}

class SignUpViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: SignUpViewModel
    
    private let scrollView = TPKeyboardAvoidingScrollView()
    private let topicView = TopicView()
    private let signUpFormStack = UIStackView()
    private let nameTextField = TextField()
    private let emailTextField = TextField()
    private let passwordTextField = PasswordTextField()
    private let signUpButton = StandartButton()
    
    // MARK: - Init
    init(viewModel: SignUpViewModel) {
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
        viewModel.didReceiveErrors = { [weak self] errors in
            self?.showMultipleErrors(errors)
        }
    }
    
    private func setup() {
        setupView()
        setupScrollView()
        setupTopicView()
        setupSignUpFormStack()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
    }
    
    private func setupView() {
        view.backgroundColor = R.color.white()
        
        view.addSubview(scrollView)
        scrollView.addSubview(topicView)
        scrollView.addSubview(signUpFormStack)
        signUpFormStack.addArrangedSubview(nameTextField)
        signUpFormStack.addArrangedSubview(emailTextField)
        signUpFormStack.addArrangedSubview(passwordTextField)
        signUpFormStack.addArrangedSubview(signUpButton)
    }
    
    private func setupScrollView() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTopicView() {
        topicView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(Dimensions.topScreenMargin)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupSignUpFormStack() {
        signUpFormStack.axis = .vertical
        signUpFormStack.spacing = Dimensions.standart
        
        signUpFormStack.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(topicView.snp.bottom)
                .offset(Dimensions.standart)
            make.bottom.equalToSuperview()
                .inset(Dimensions.bottomScreenMaxMargin)
            make.leading.trailing.equalToSuperview()
                .inset(Dimensions.standart)
        }
    }
    
    private func setupNameTextField() {
        nameTextField.textContentType = .name
        nameTextField.setPlaceholder(R.string.signUp.namePlaceholder())
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    private func setupEmailTextField() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.textContentType = .emailAddress
        emailTextField.setPlaceholder(R.string.signUp.emailPlaceholder())
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    private func setupPasswordTextField() {
        passwordTextField.setPlaceholder(R.string.signUp.passwordPlaceholder())
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    // MARK: - Private methods
    private func setupSignUpButton() {
        signUpButton.addTarget(
            self,
            action: #selector(signUp),
            for: .touchUpInside)
        signUpButton.setTitle(R.string.signUp.signUp(), for: .normal)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.standartHeight)
        }
    }
    
    // MARK: - Actions
    @objc private func signUp() {
        viewModel.signUp(
            name: nameTextField.text,
            email: emailTextField.text,
            password: passwordTextField.text)
    }
}
