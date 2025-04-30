import SnapKit
import UIKit

final class CurrentLocationButtonView: UIView {
    let button = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(button)

        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.tintColor = .triOSSecondaryText
        button.backgroundColor = .triOSBackground
        button.layer.cornerRadius = 22
        button.clipsToBounds = true

        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
