import UIKit

final class BatterySelectedView: UIView {
    var onTapped: ((Int) -> Void)?

    private let highBatteryIconView = BatteryView()
    private let midBatteryIconView = BatteryView()
    private let lowBatteryIconView = BatteryView()
    private let batteryStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        highBatteryIconView.updateUI(
            backgroundColor: .triOSHighBatteryBackground,
            icon: "battery.100",
            tintColor: .triOSHighBattery,
            rate: "100%"
        )
        highBatteryIconView.onTapped = { [weak self] in
            self?.onTapped?(0)
        }

        midBatteryIconView.updateUI(
            backgroundColor: .triOSMidBatteryBackground,
            icon: "battery.50",
            tintColor: .triOSMidBattery,
            rate: "50%"
        )
        midBatteryIconView.onTapped = { [weak self] in
            self?.onTapped?(1)
        }

        lowBatteryIconView.updateUI(
            backgroundColor: .triOSLowBatteryBackground,
            icon: "battery.25",
            tintColor: .triOSLowBattery,
            rate: "25%"
        )
        lowBatteryIconView.onTapped = { [weak self] in
            self?.onTapped?(2)
        }

        batteryStackView.axis = .horizontal
        batteryStackView.alignment = .center
        batteryStackView.distribution = .equalCentering

        [highBatteryIconView, midBatteryIconView, lowBatteryIconView]
            .forEach { batteryStackView.addArrangedSubview($0) }

        [batteryStackView]
            .forEach { addSubview($0) }

        highBatteryIconView.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        midBatteryIconView.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        lowBatteryIconView.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        batteryStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateBatteryViews(at index: Int) {
        for (idx, subview) in batteryStackView.arrangedSubviews.enumerated() {
            if let battery = subview as? BatteryView {
                battery.seleted(idx == index)
            }
        }
    }
}
