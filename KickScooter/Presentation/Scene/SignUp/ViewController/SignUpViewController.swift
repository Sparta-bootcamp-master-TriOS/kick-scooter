import RiveRuntime
import SnapKit
import UIKit

final class SignUpViewController: UIViewController {
    private let signUpViewModel: SignUpViewModel

    weak var delegate: SignUpViewControllerDelegate?

    private let riveViewModel = RiveViewModel(fileName: "KickScooter", stateMachineName: "State Machine")
    var riveView = RiveView()

    let scrollView = UIScrollView()
    let contentView = UIView()
    let nameTextField = SignUpTextField()
    let invalidNameLabel = InvalidLabel()
    let idTextField = SignUpTextField()
    let invalidIDLabel = InvalidLabel()
    let passwordTextField = SignUpTextField()
    let invalidPasswordLabel = InvalidLabel()
    let confirmPasswordTextField = SignUpTextField()
    let invalidConfirmPasswordLabel = InvalidLabel()
    let emailTextField = SignUpTextField()
    let invalidEmailLabel = InvalidLabel()
    let signUpButton = CommonButton()

    init(signUpViewModel: SignUpViewModel) {
        self.signUpViewModel = signUpViewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureScrollViewConstraints()
        configureRiveViewConstraints()
        configureTextFieldConstraints()
        configureInvalidLabelConstraints()
        configureSignUpButtonConstraints()
        configureBindings()
        configureKeyboardNotifications()
    }

    private func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        nameTextField.delegate = self
        idTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailTextField.delegate = self

        view.backgroundColor = .triOSTertiaryBackground

        scrollView.showsVerticalScrollIndicator = false

        riveView = riveViewModel.createRiveView()

        idTextField.keyboardType = .asciiCapable
        passwordTextField.keyboardType = .asciiCapable
        confirmPasswordTextField.keyboardType = .asciiCapable
        emailTextField.keyboardType = .emailAddress

        configureTextFields()
        configureInvalidLabels()

        signUpButton.updateUI(backgroundColor: .triOSMain, titleColor: .triOSTertiaryBackground, title: "Sign Up")

        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        [
            riveView,
            nameTextField, invalidNameLabel,
            idTextField, invalidIDLabel,
            passwordTextField, invalidPasswordLabel,
            confirmPasswordTextField, invalidConfirmPasswordLabel,
            emailTextField, invalidEmailLabel,
            signUpButton,
        ]
        .forEach { contentView.addSubview($0) }
    }

    private func configureTextFields() {
        nameTextField.updateUI(placeholder: "이름")
        idTextField.updateUI(placeholder: "아이디")
        passwordTextField.updateUI(placeholder: "비밀번호", isSecureTextEntry: true)
        confirmPasswordTextField.updateUI(placeholder: "비밀번호 확인", isSecureTextEntry: true)
        emailTextField.updateUI(placeholder: "이메일")
    }

    private func configureInvalidLabels() {
        invalidNameLabel.emptyText = "이름을 입력해주세요."
        invalidNameLabel.invalidText = "한글만 입력할 수 있습니다."

        invalidIDLabel.emptyText = "아이디를 입력해주세요."
        invalidIDLabel.invalidText = "아이디는 영문과 숫자만 사용할 수 있습니다."
        invalidIDLabel.duplicatedIDText = "이미 사용중인 아이디입니다."

        invalidPasswordLabel.emptyText = "비밀번호를 입력해주세요."
        invalidPasswordLabel.invalidText = "비밀번호는 최소 8자 이상이어야 합니다."

        invalidConfirmPasswordLabel.emptyText = "비밀번호 확인을 입력해주세요."
        invalidConfirmPasswordLabel.invalidText = "비밀번호가 일치하지 않습니다."

        invalidEmailLabel.emptyText = "이메일을 입력해주세요."
        invalidEmailLabel.invalidText = "유효하지 않은 이메일 주소입니다."
    }

    private func configureBindings() {
        bindValidation(
            textField: nameTextField,
            label: invalidNameLabel,
            validation: signUpViewModel.verifyKoreanName
        )

        bindValidation(
            textField: idTextField,
            label: invalidIDLabel,
            validation: signUpViewModel.verifyID
        )

        bindValidation(
            textField: passwordTextField,
            label: invalidPasswordLabel,
            validation: signUpViewModel.verifyPassword
        )

        confirmPasswordTextField.onTextChanged = { [weak self] in
            guard let self,
                  let password = self.passwordTextField.text,
                  let confirmPassword = self.confirmPasswordTextField.text
            else {
                return
            }

            let isVerified = self.signUpViewModel.verifyPasswordsMatch(password, confirmPassword)
            self.invalidConfirmPasswordLabel.isHidden = isVerified

            if !isVerified {
                self.invalidConfirmPasswordLabel.showInvalidMessage()
            }
        }

        bindValidation(
            textField: emailTextField,
            label: invalidEmailLabel,
            validation: signUpViewModel.verifyEmail
        )

        signUpButton.onButtonTapped = { [weak self] in
            guard let self else { return }

            let isValidated = self.validateTextFields()

            if !isValidated { return }

            guard let id = self.idTextField.text else { return }
            let isAvialable = self.signUpViewModel.verifyIDAvailability(id)

            if isAvialable {
                guard let user = self.user() else { return }

                self.signUpViewModel.signUp(user: user)

                self.delegate?.pop()
            } else {
                invalidIDLabel.showduplicatedIDMessage()

                _ = idTextField.becomeFirstResponder()
                idTextField.shake()
            }
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

    private func bindValidation(
        textField: SignUpTextField,
        label: InvalidLabel,
        validation: @escaping (String) -> Bool
    ) {
        textField.onTextChanged = {
            guard let text = textField.text else { return }

            let isVerified = validation(text)
            label.isHidden = isVerified

            if !isVerified {
                label.showInvalidMessage()
            }
        }
    }

    private func validateTextFields() -> Bool {
        let validations: [ValidationItem] = [
            ValidationItem(
                textField: nameTextField,
                label: invalidNameLabel,
                validation: signUpViewModel.verifyKoreanName
            ),
            ValidationItem(
                textField: idTextField,
                label: invalidIDLabel,
                validation: signUpViewModel.verifyID
            ),
            ValidationItem(
                textField: passwordTextField,
                label: invalidPasswordLabel,
                validation: signUpViewModel.verifyPassword
            ),
            ValidationItem(
                textField: confirmPasswordTextField,
                label: invalidConfirmPasswordLabel,
                validation: { [weak self] text in
                    guard let self else { return false }
                    return self.signUpViewModel.verifyPasswordsMatch(self.passwordTextField.text ?? "", text)
                }
            ),
            ValidationItem(
                textField: emailTextField,
                label: invalidEmailLabel,
                validation: signUpViewModel.verifyEmail
            ),
        ]

        for item in validations {
            guard let text = item.textField.text, !text.isEmpty else {
                item.label.showEmptyMessage()
                _ = item.textField.becomeFirstResponder()
                item.textField.shake()

                return false
            }

            if !item.validation(text) {
                item.label.showInvalidMessage()
                _ = item.textField.becomeFirstResponder()
                item.textField.shake()

                return false
            }
        }

        return true
    }

    private func user() -> UserSignUpUI? {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let id = idTextField.text,
              let password = passwordTextField.text
        else {
            return nil
        }

        return UserSignUpUI(
            name: name,
            email: email,
            id: id,
            password: password
        )
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
    }
}
