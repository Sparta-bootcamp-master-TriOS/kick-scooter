import RiveRuntime
import SnapKit
import UIKit

final class MainViewController: UIViewController {
    private let mainViewModel: MainViewModel

    weak var delegate: MainViewControllerDelegate?

    private let riveViewModel = RiveViewModel(fileName: "SignIn", stateMachineName: "Login Machine")
    private var riveView = RiveView()

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel = UILabel()
    let idTextField = IDTextField()
    let passwordTextField = PasswordTextField()
    private let invalidLabel = InvalidLabel()
    private let checkBoxStackView = UIStackView()
    private let rememberCheckBox = SignInCheckBox()
    private let autoCheckBox = SignInCheckBox()
    let signInButton = CommonButton()
    private let orLabel = UILabel()
    private let signUpButton = CommonButton()

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewModel.savedCredentials()

        configureUI()
        configureConstraints()
        configureBindings()
        configureKeyboardNotifications()
        configureBackButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !mainViewModel.didApplyCredentials {
            applyCredentials()
            mainViewModel.toggleDidApplyCredentials()
        } else {
            idTextField.text = ""
            passwordTextField.text = ""

            invalidLabel.isHidden = true

            rememberCheckBox.isSelected = false
            autoCheckBox.isSelected = false
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.endEditing(true)
    }

    private func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        idTextField.delegate = self
        passwordTextField.delegate = self

        view.backgroundColor = .triOSTertiaryBackground

        scrollView.showsVerticalScrollIndicator = false

        titleLabel.text = "SHOONG"
        titleLabel.textColor = .triOSText
        titleLabel.font = .jalnan(ofSize: 52)
        titleLabel.textAlignment = .center

        riveView = riveViewModel.createRiveView()

        checkBoxStackView.axis = .horizontal
        checkBoxStackView.alignment = .center
        checkBoxStackView.distribution = .fillEqually

        rememberCheckBox.updateTitle("계정 기억하기")
        rememberCheckBox.isSelected = mainViewModel.rememberSignInStatus

        autoCheckBox.updateTitle("자동 로그인")
        autoCheckBox.isSelected = mainViewModel.autoSignInStatus

        signUpButton.updateUI(backgroundColor: .triOSBackground, titleColor: .triOSText, title: "회원가입")
        signInButton.updateUI(backgroundColor: .triOSMain, titleColor: .triOSTertiaryBackground, title: "로그인")

        orLabel.text = "또는"
        orLabel.textColor = .triOSText
        orLabel.font = .jalnan(ofSize: 16)

        invalidLabel.text = "아이디 또는 비밀번호가 잘못되었습니다."

        view.addSubview(scrollView)

        [rememberCheckBox, autoCheckBox]
            .forEach { checkBoxStackView.addArrangedSubview($0) }

        scrollView.addSubview(contentView)

        [
            titleLabel,
            riveView,
            idTextField,
            passwordTextField,
            invalidLabel,
            checkBoxStackView,
            signInButton,
            orLabel,
            signUpButton,
        ]
        .forEach { contentView.addSubview($0) }
    }

    private func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView)
            $0.bottom.equalTo(signUpButton)
        }

        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        riveView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(-30)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(300)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(riveView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        invalidLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        checkBoxStackView.snp.makeConstraints {
            $0.top.equalTo(invalidLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        signInButton.snp.makeConstraints {
            $0.top.equalTo(checkBoxStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }

        orLabel.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(orLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(40)
        }
    }

    private func configureBindings() {
        signInButton.onButtonTapped = { [weak self] in
            guard let self else { return }

            let isAuthorized = self.authorize()

            self.validateTextFields()

            self.riveViewModel.triggerInput(isAuthorized ? "trigSuccess" : "trigFail")

            if isAuthorized {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    self.delegate?.successSignIn()
                }
            }
        }

        signUpButton.onButtonTapped = { [weak self] in
            self?.delegate?.pushSignUp()
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

        rememberCheckBox.onToggle = { [weak self] isSelected in
            self?.mainViewModel.toggleRememberSignInStatus(status: isSelected)
        }

        autoCheckBox.onToggle = { [weak self] isSelected in
            self?.mainViewModel.toggleAutoSignInStatus(status: isSelected)
        }
    }

    private func configureKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
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

    private func applyCredentials() {
        if mainViewModel.rememberSignInStatus {
            idTextField.text = mainViewModel.credentials?.id
            passwordTextField.text = mainViewModel.credentials?.password
            rememberCheckBox.isSelected = true
        }

        if mainViewModel.autoSignInStatus {
            autoCheckBox.isSelected = true

            mainViewModel.signIn()

            delegate?.successSignIn()
        }
    }

    @objc
    private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardHeight = keyboardFrame.height

        scrollView.isScrollEnabled = true
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }

    @objc
    private func keyboardWillHide(notification _: Notification) {
        scrollView.isScrollEnabled = false
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)

        riveViewModel.setInput("isChecking", value: false)
        riveViewModel.setInput("isHandsUp", value: false)
    }
}
