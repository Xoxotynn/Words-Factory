import UIKit
import SnapKit

// MARK: Strings
private extension Strings {
    static let signUp = "Sign Up"
    static let createAccount = "Create your account"
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
    
    private let welcomeImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let signUpFormStack = UIStackView()
    private let nameTextField = TextField()
    private let emailTextField = TextField()
    private let passwordTextField = TextField()
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
        setup()
    }
    
    // MARK: Private setup methods
    private func bindToViewModel() {
        
    }
    
    private func setup() {
        setupView()
        setupWelcomeImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupSignUpFormStack()
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignUpButton()
    }
    
    private func setupView() {
        view.backgroundColor = .appWhite
        
        view.addSubview(welcomeImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(signUpFormStack)
        signUpFormStack.addArrangedSubview(nameTextField)
        signUpFormStack.addArrangedSubview(emailTextField)
        signUpFormStack.addArrangedSubview(passwordTextField)
        signUpFormStack.addArrangedSubview(signUpButton)
    }
    
    private func setupWelcomeImageView() {
        welcomeImageView.image = .standingKid
        welcomeImageView.contentMode = .scaleAspectFit
        
        welcomeImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.standart)
                .priority(.high)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide)
                .inset(Dimensions.topScreenMargin)
            make.bottom.equalTo(titleLabel.snp.top)
                .offset(-Dimensions.standart)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Strings.signUp
        titleLabel.setupAsTitle()
        titleLabel.numberOfLines = 1
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subtitleLabel.snp.top)
                .offset(-Dimensions.small)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.text = Strings.createAccount
        subtitleLabel.setupAsSubtitle()
        subtitleLabel.numberOfLines = 0
        
        subtitleLabel.snp.makeConstraints { make in
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
        nameTextField.setPlaceholder(Strings.namePlaceholder)
        
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.textFieldHeight)
        }
    }
    
    private func setupEmailTextField() {
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.setPlaceholder(Strings.emailPlaceholder)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.textFieldHeight)
        }
    }
    
    private func setupPasswordTextField() {
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.setPlaceholder(Strings.passwordPlaceholder)
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.textFieldHeight)
        }
    }
    
    private func setupSignUpButton() {
        signUpButton.setTitle(Strings.signUp, for: .normal)
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(Dimensions.standartButtonHeight)
        }
    }
}
