import RiveRuntime
import SnapKit
import UIKit

final class SignUpViewController: UIViewController {
    private let signUpViewModel: SignUpViewModel

    weak var delegate: SignUpViewControllerDelegate?

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
        invalidNameLabel.emptyText = "이름을 입력해주세요."
        invalidNameLabel.invalidText = "한글만 입력할 수 있습니다."

        idTextField.updateUI(placeholder: "아이디")
        invalidIDLabel.emptyText = "아이디를 입력해주세요."
        invalidIDLabel.invalidText = "아이디는 영문과 숫자만 사용할 수 있습니다."

        passwordTextField.updateUI(placeholder: "비밀번호", isSecureTextEntry: true)
        invalidPasswordLabel.emptyText = "비밀번호를 입력해주세요."
        invalidPasswordLabel.invalidText = "비밀번호는 최소 8자 이상이어야 합니다."

        confirmPasswordTextField.updateUI(placeholder: "비밀번호 확인", isSecureTextEntry: true)
        invalidConfirmPasswordLabel.emptyText = "비밀번호 확인을 입력해주세요."
        invalidConfirmPasswordLabel.invalidText = "비밀번호가 일치하지 않습니다."

        emailTextField.updateUI(placeholder: "이메일")
        invalidEmailLabel.emptyText = "이메일을 입력해주세요."
        invalidEmailLabel.invalidText = "유효하지 않은 이메일 주소입니다."

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

            guard let id = self.idTextField.text else { return }
            let isAvialable = self.signUpViewModel.verifyIDAvailability(id)

            if isValidated, isAvialable {
                guard let user = self.user() else { return }

                self.signUpViewModel.signUp(user: user)

                self.delegate?.pop()
            }
        }
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
}
