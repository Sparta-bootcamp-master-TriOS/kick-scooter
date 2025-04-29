import SnapKit
import UIKit

final class CommonButton: UIButton {
    var onButtonTapped: (() -> Void)?

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted
                ? backgroundColor?.withAlphaComponent(0.7)
                : backgroundColor?.withAlphaComponent(1)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        titleLabel?.font = .systemFont(ofSize: 18)
        layer.cornerRadius = 23

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        snp.makeConstraints {
            $0.height.equalTo(46)
        }
    }

    func updateUI(backgroundColor: UIColor, titleColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        setTitle(title, for: .normal)
    }

    @objc
    private func buttonTapped() {
        onButtonTapped?()
    }
}
