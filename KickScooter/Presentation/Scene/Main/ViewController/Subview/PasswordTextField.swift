import UIKit

final class PasswordTextField: UITextField {
    var onEditingBegan: (() -> Void)?
    var onVisibilityDisabled: (() -> Void)?
    var onVisibilityEnabled: (() -> Void)?

    private let underline = CALayer()
    let eyeButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        borderStyle = .none
        underline.frame = CGRect(x: 0, y: bounds.height, width: bounds.width, height: 1)

        if underline.superlayer == nil {
            layer.addSublayer(underline)
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }

    override func becomeFirstResponder() -> Bool {
        underline.backgroundColor = UIColor.triOSMain.cgColor

        onEditingBegan?()

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        underline.backgroundColor = UIColor.triOSMainBlack.cgColor

        return super.resignFirstResponder()
    }

    private func configureUI() {
        keyboardType = .asciiCapable

        underline.backgroundColor = UIColor.triOSMainBlack.cgColor

        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.tintColor = .triOSText
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        textColor = .triOSText
        rightView = eyeButton
        rightViewMode = .always
        font = .jalnan(ofSize: 16)
        isSecureTextEntry = true

        attributedPlaceholder = NSAttributedString(
            string: "비밀번호를 입력하세요.",
            attributes: [
                .font: UIFont.jalnan(ofSize: 16),
                .foregroundColor: UIColor.triOSSecondaryText,
            ]
        )
    }

    @objc
    private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()

        if isSecureTextEntry {
            onVisibilityEnabled?()
        } else {
            onVisibilityDisabled?()
        }

        let eyeImageName = isSecureTextEntry ? "eye" : "eye.slash"
        eyeButton.setImage(UIImage(systemName: eyeImageName), for: .normal)
    }
}
