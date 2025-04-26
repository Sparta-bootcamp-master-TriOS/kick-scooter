import RiveRuntime
import SnapKit
import UIKit

final class SignUpViewController: UIViewController {
    private let riveViewModel = RiveViewModel(fileName: "KickScooter", stateMachineName: "State Machine")
    private var riveView = RiveView()

    private let nameTextField = SignUpTextField()
    private let idTextField = SignUpTextField()
    private let passwordTextField = SignUpTextField()
    private let confirmPasswordTextField = SignUpTextField()
    private let invalidLabel = UILabel()
    private let emailTextField = SignUpTextField()
    private let signUpButton = SignButton()

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

        emailTextField.updateUI(placeholder: "이메일")

        idTextField.updateUI(placeholder: "아이디")

        passwordTextField.updateUI(placeholder: "비밀번호", isSecureTextEntry: true)
        confirmPasswordTextField.updateUI(placeholder: "비밀번호 확인", isSecureTextEntry: true)

        invalidLabel.textColor = .triOSLowBattery
        invalidLabel.font = .systemFont(ofSize: 16)
        invalidLabel.isHidden = true
        invalidLabel.text = "비밀번호가 일치하지 않습니다."

        signUpButton.updateUI(backgroundColor: .triOSMain, titleColor: .triOSTertiaryBackground, title: "회원가입")

        [
            riveView,
            nameTextField,
            idTextField,
            passwordTextField,
            confirmPasswordTextField,
            invalidLabel,
            emailTextField,
            signUpButton,
        ]
        .forEach { view.addSubview($0) }
    }

    private func configureConstraints() {
        riveView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(nameTextField.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }

        nameTextField.snp.makeConstraints {
            $0.bottom.equalTo(emailTextField.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        emailTextField.snp.makeConstraints {
            $0.bottom.equalTo(idTextField.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        idTextField.snp.makeConstraints {
            $0.bottom.equalTo(passwordTextField.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.bottom.equalTo(confirmPasswordTextField.snp.top).offset(-20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        confirmPasswordTextField.snp.makeConstraints {
            $0.bottom.equalTo(invalidLabel.snp.top).offset(-10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        invalidLabel.snp.makeConstraints {
            $0.bottom.equalTo(signUpButton.snp.top).offset(-30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
        }

        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(60)
            $0.height.equalTo(46)
        }
    }

    private func configureBindings() {
        passwordTextField.onTextChanged = { [weak self] in
            self?.verifyPasswordsMatch()
        }

        confirmPasswordTextField.onTextChanged = { [weak self] in
            self?.verifyPasswordsMatch()
        }

        signUpButton.onButtonTapped = { [weak self] in
            self?.validateTextFields()
        }
    }

    private func verifyPasswordsMatch() {
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text

        invalidLabel.isHidden = password == confirmPassword
    }

    private func validateTextFields() {
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
        }
    }
}
