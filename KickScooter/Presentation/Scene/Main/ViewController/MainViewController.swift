import RiveRuntime
import SnapKit
import UIKit

final class MainViewController: UIViewController {
    private let mainViewModel: MainViewModel

    weak var delegate: MainViewControllerDelegate?

    private let riveViewModel = RiveViewModel(fileName: "SignIn", stateMachineName: "Login Machine")
    private var riveView = RiveView()

    private let signUpButton = SignButton()
    private let signInButton = SignButton()
    private let orLabel = UILabel()
    private let passwordTextField = PasswordTextField()
    private let idTextField = IDTextField()
    private let invalidLabel = InvalidLabel()

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        configureBindings()
        configureBackButton()
    }

    private func configureUI() {
        view.backgroundColor = .triOSTertiaryBackground

        riveView = riveViewModel.createRiveView()

        signUpButton.updateUI(backgroundColor: .triOSBackground, titleColor: .triOSText, title: "Sign Up")
        signInButton.updateUI(backgroundColor: .triOSMain, titleColor: .triOSTertiaryBackground, title: "Sign In")

        orLabel.text = "or"
        orLabel.textColor = .triOSText
        orLabel.font = .systemFont(ofSize: 16)

        invalidLabel.text = "아이디 또는 비밀번호가 잘못되었습니다."

        [riveView, signUpButton, signInButton, orLabel, passwordTextField, idTextField, invalidLabel]
            .forEach { view.addSubview($0) }
    }

    private func configureConstraints() {
        riveView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(idTextField.snp.top)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(46)
        }

        orLabel.snp.makeConstraints {
            $0.bottom.equalTo(signUpButton.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
        }

        signInButton.snp.makeConstraints {
            $0.bottom.equalTo(orLabel.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.height.equalTo(46)
        }

        invalidLabel.snp.makeConstraints {
            $0.bottom.equalTo(signInButton.snp.top).offset(-30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidLabel.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(passwordTextField.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }

    private func configureBindings() {
        signInButton.onButtonTapped = { [weak self] in
            guard let self else { return }

            let isAuthorized = self.authorize()

            self.validateTextFields()

            self.riveViewModel.setInput("isChecking", value: false)
            self.riveViewModel.triggerInput(isAuthorized ? "trigSuccess" : "trigFail")
        }

        signUpButton.onButtonTapped = { [weak self] in
            self?.delegate?.push()
        }

        idTextField.onEditingBegan = { [weak self] in
            self?.riveViewModel.setInput("isHandsUp", value: false)
            self?.riveViewModel.setInput("isChecking", value: true)
        }

        idTextField.onTextChanged = { [weak self] text in
            self?.riveViewModel.setInput("numLook", value: Double(text.count * 3))
        }

        passwordTextField.onEditingBegan = { [weak self] in
            self?.riveViewModel.setInput("isHandsUp", value: true)
            self?.riveViewModel.setInput("isChecking", value: false)
        }

        passwordTextField.onVisibilityDisabled = { [weak self] in
            self?.riveViewModel.setInput("isPicking", value: true)
        }

        passwordTextField.onVisibilityEnabled = { [weak self] in
            self?.riveViewModel.setInput("isPicking", value: false)
        }
    }

    private func configureBackButton() {
        navigationItem.backButtonTitle = "Sign In"
    }

    private func validateTextFields() {
        let textFields: [UITextField] = [
            idTextField,
            passwordTextField,
        ]

        if let emptyField = textFields.first(where: { $0.text?.isEmpty == true }) {
            _ = emptyField.becomeFirstResponder()
            emptyField.shake()
        }
    }

    private func authorize() -> Bool {
        guard let id = idTextField.text, !id.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            return false
        }

        let isAuthorized = mainViewModel.authorize(user: UserSignInUI(id: id, password: password))
        invalidLabel.isHidden = isAuthorized

        return isAuthorized
    }
}
