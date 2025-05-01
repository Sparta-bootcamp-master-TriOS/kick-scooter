import SnapKit
import UIKit

final class SignOutButtonCell: UICollectionViewCell {
    static let identifier = "SignOutCell"

    let button = UIButton()

    var onTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        button.addTarget(self, action: #selector(didTapped), for: .touchUpInside)

        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.triOSRedButton, for: .normal)
        button.setTitleColor(.triOSRedButton.withAlphaComponent(0.7), for: .highlighted)
        button.titleLabel?.font = .jalnan(ofSize: 18)

        contentView.addSubview(button)

        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc
    private func didTapped() {
        onTapped?()
    }
}
