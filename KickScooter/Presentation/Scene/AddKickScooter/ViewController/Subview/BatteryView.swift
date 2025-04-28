import UIKit

final class BatteryView: UIView {
    var onTapped: (() -> Void)?

    private var selectedBackgroundColor: UIColor = .clear

    private let batterIconView = UIView()
    private let batteryIcon = UIImageView()
    private let batteryRateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        batterIconView.layer.cornerRadius = 24

        batteryIcon.contentMode = .center

        let batteryLabel = UILabel()
        batteryLabel.text = "Battery"
        batteryLabel.font = .systemFont(ofSize: 14)
        batteryLabel.textColor = .triOSSecondaryText

        batteryRateLabel.font = .systemFont(ofSize: 16)
        batteryRateLabel.textColor = .triOSText

        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading

        batterIconView.addSubview(batteryIcon)

        [batteryLabel, batteryRateLabel]
            .forEach { labelStackView.addArrangedSubview($0) }

        [batterIconView, labelStackView]
            .forEach { addSubview($0) }

        batterIconView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(48)
        }

        batteryIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(30)
        }

        labelStackView.snp.makeConstraints {
            $0.left.equalTo(batterIconView.snp.right).offset(4)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview()
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }

    func updateUI(backgroundColor: UIColor, icon: String, tintColor: UIColor, rate: String) {
        selectedBackgroundColor = backgroundColor
        batteryIcon.image = UIImage(systemName: icon)
        batteryIcon.tintColor = tintColor
        batteryRateLabel.text = rate
    }

    func seleted(_ isSelected: Bool) {
        batterIconView.backgroundColor = isSelected ? selectedBackgroundColor : .clear
    }

    @objc
    private func tapped() {
        onTapped?()
    }
}
