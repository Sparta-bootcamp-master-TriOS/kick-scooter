import RiveRuntime
import SnapKit
import UIKit

final class SignUpViewController: UIViewController {
    private let signUpViewModel: SignUpViewModel

    private let riveViewModel = RiveViewModel(fileName: "KickScooter", stateMachineName: "State Machine")
    private var riveView = RiveView()

    private let nameTextField = SignUpTextField()
    private let invalidNameLabel = InvalidLabel()
    private let idTextField = SignUpTextField()
    private let invalidIDLabel = InvalidLabel()
    private let passwordTextField = SignUpTextField()
    private let invalidPasswordLabel = InvalidLabel()
    private let confirmPasswordTextField = SignUpTextField()
    private let invalidConfirmPasswordLabel = InvalidLabel()
    private let emailTextField = SignUpTextField()
    private let invalidEmailLabel = InvalidLabel()
    private let signUpButton = SignButton()

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
        configureConstraints()
        configureBindings()
    }

    private func configureUI() {
        view.backgroundColor = .triOSTertiaryBackground

        riveView = riveViewModel.createRiveView()

        nameTextField.updateUI(placeholder: "이름")
        invalidNameLabel.text = "한글만 입력할 수 있습니다."

        idTextField.updateUI(placeholder: "아이디")
        invalidIDLabel.text = "아이디는 영문과 숫자만 사용할 수 있습니다."

        passwordTextField.updateUI(placeholder: "비밀번호", isSecureTextEntry: true)
        invalidPasswordLabel.text = "비밀번호는 최소 8자 이상이어야 합니다."

        confirmPasswordTextField.updateUI(placeholder: "비밀번호 확인", isSecureTextEntry: true)
        invalidConfirmPasswordLabel.text = "비밀번호가 일치하지 않습니다."

        emailTextField.updateUI(placeholder: "이메일")
        invalidEmailLabel.text = "유효하지 않은 이메일 주소입니다."

        signUpButton.updateUI(backgroundColor: .triOSMain, titleColor: .triOSTertiaryBackground, title: "Sign Up")

        [
            riveView,
            nameTextField, invalidNameLabel,
            idTextField, invalidIDLabel,
            passwordTextField, invalidPasswordLabel,
            confirmPasswordTextField, invalidConfirmPasswordLabel,
            emailTextField, invalidEmailLabel,
            signUpButton,
        ]
        .forEach { view.addSubview($0) }
    }

    private func configureConstraints() {
        riveView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(nameTextField.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }

        nameTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidNameLabel.snp.top).offset(-3)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        invalidNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(idTextField.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidIDLabel.snp.top).offset(-3)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        invalidIDLabel.snp.makeConstraints {
            $0.bottom.equalTo(passwordTextField.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidPasswordLabel.snp.top).offset(-3)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        invalidPasswordLabel.snp.makeConstraints {
            $0.bottom.equalTo(confirmPasswordTextField.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        confirmPasswordTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidConfirmPasswordLabel.snp.top).offset(-3)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        invalidConfirmPasswordLabel.snp.makeConstraints {
            $0.bottom.equalTo(emailTextField.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        emailTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidEmailLabel.snp.top).offset(-3)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        invalidEmailLabel.snp.makeConstraints {
            $0.bottom.equalTo(signUpButton.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.height.equalTo(46)
        }
    }

    private func configureBindings() {
        nameTextField.onTextChanged = { [weak self] in
            guard let self,
                  let name = self.nameTextField.text else { return }

            let isVerified = self.signUpViewModel.verifyKoreanName(name)
            invalidNameLabel.isHidden = isVerified
        }

        idTextField.onTextChanged = { [weak self] in
            guard let self,
                  let id = self.idTextField.text
            else {
                return
            }

            let isVerified = self.signUpViewModel.verifyID(id)
            invalidIDLabel.isHidden = isVerified
        }

        passwordTextField.onTextChanged = { [weak self] in
            guard let self,
                  let password = self.passwordTextField.text
            else {
                return
            }

            let isVerified = self.signUpViewModel.verifyPassword(password)
            invalidPasswordLabel.isHidden = isVerified
        }

        confirmPasswordTextField.onTextChanged = { [weak self] in
            guard let self,
                  let password = self.passwordTextField.text,
                  let confirmPassword = self.confirmPasswordTextField.text
            else {
                return
            }

            let isVerified = self.signUpViewModel.verifyPasswordsMatch(password, confirmPassword)
            invalidConfirmPasswordLabel.isHidden = isVerified
        }

        emailTextField.onTextChanged = { [weak self] in
            guard let self,
                  let email = self.emailTextField.text
            else {
                return
            }

            let isVerified = self.signUpViewModel.verifyEmail(email)
            invalidEmailLabel.isHidden = isVerified
        }

        signUpButton.onButtonTapped = { [weak self] in
            guard let self else { return }

            let isValidated = self.validateTextFields()
            let isAvialable = self.signUpViewModel.verifyIDAvailability()

            if isValidated, isAvialable {
                guard let user = self.user() else { return }

                signUpViewModel.signUp(user: user)
            }
        }
    }

    private func validateTextFields() -> Bool {
        let textFields: [UITextField] = [
            nameTextField,
            emailTextField,
            idTextField,
            passwordTextField,
            confirmPasswordTextField,
        ]

        if let emptyField = textFields.first(where: { $0.text?.isEmpty == true }) {
            _ = emptyField.becomeFirstResponder()
            emptyField.shake()

            return false
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
}
