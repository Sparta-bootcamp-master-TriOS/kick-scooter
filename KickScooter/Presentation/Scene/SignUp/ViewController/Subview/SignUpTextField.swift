import UIKit

final class SignUpTextField: UITextField {
    var onTextChanged: (() -> Void)?

    private let underline = CALayer()

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

        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
        underline.backgroundColor = UIColor.triOSMainBlack.cgColor

        return super.resignFirstResponder()
    }

    private func configureUI() {
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        underline.backgroundColor = UIColor.triOSMainBlack.cgColor

        textColor = .triOSText
        font = .jalnan(ofSize: 16)
        autocapitalizationType = .none
        autocorrectionType = .no
    }

    func updateUI(placeholder: String, isSecureTextEntry: Bool = false) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .font: UIFont.jalnan(ofSize: 16),
                .foregroundColor: UIColor.triOSSecondaryText,
            ]
        )

        self.isSecureTextEntry = isSecureTextEntry
    }

    @objc
    private func textFieldDidChange() {
        onTextChanged?()
    }
}
