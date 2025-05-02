import SnapKit
import UIKit

final class MapActionButtonPanel: UIView {
    var onLocationButtonTapped: (() -> Void)?

    let toggleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        button.tintColor = .triOSSecondaryText
        button.backgroundColor = .triOSBackground
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        return button
    }()

    let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.tintColor = .triOSSecondaryText
        button.backgroundColor = .triOSBackground
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        return button
    }()

    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [toggleButton, locationButton])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(buttonStackView)

        buttonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        toggleButton.snp.makeConstraints {
            $0.height.width.equalTo(44)
        }
        locationButton.snp.makeConstraints {
            $0.height.width.equalTo(44)
        }

        locationButton.addTarget(self, action: #selector(didLocationButtonTapped), for: .touchUpInside)
    }

    func toggleState(isOn: Bool) {
        toggleButton.tintColor = isOn ? .triOSMain : .triOSSecondaryText
    }

    @objc
    private func didLocationButtonTapped() {
        onLocationButtonTapped?()
    }
}
