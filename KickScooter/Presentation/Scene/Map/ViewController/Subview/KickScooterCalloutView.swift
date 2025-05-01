import SnapKit
import UIKit

final class KickScooterCalloutView: UIView {
    var onReserveTapped: (() -> Void)?

    private let imageView = UIImageView()
    private let modelLabel = UILabel()
    let batteryView = UIStackView()
    private let batterIconView = UIView()
    private let batteryIcon = UIImageView()
    private let batteryRateLabel = UILabel()
    private let priceLabel = UILabel()
    private let rightStackView = UIStackView()
    private let topStackView = UIStackView()
    private let reserveButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 200)
    }

    private func configureUI() {
        reserveButton.addTarget(self, action: #selector(didReserveTapped), for: .touchUpInside)

        imageView.contentMode = .scaleAspectFit

        modelLabel.font = .jalnan(ofSize: 18)
        modelLabel.textColor = .triOSText

        batteryIcon.contentMode = .center
        batteryRateLabel.font = .jalnan(ofSize: 14)
        batteryRateLabel.textColor = .triOSText

        let batteryLabel = UILabel()
        batteryLabel.text = "배터리"
        batteryLabel.font = .jalnan(ofSize: 12)
        batteryLabel.textColor = .triOSSecondaryText

        let batteryLabelStackView = UIStackView()
        batteryLabelStackView.axis = .vertical
        batteryLabelStackView.alignment = .leading

        batteryView.axis = .horizontal

        priceLabel.font = .jalnan(ofSize: 14)
        priceLabel.textColor = .triOSText
        priceLabel.textAlignment = .right

        rightStackView.axis = .vertical
        rightStackView.spacing = 10
        rightStackView.alignment = .trailing

        topStackView.axis = .horizontal
        topStackView.spacing = 12
        topStackView.alignment = .center
        topStackView.distribution = .fill

        reserveButton.setTitle("예약", for: .normal)
        reserveButton.titleLabel?.font = .jalnan(ofSize: 16)
        reserveButton.backgroundColor = .triOSMain
        reserveButton.setTitleColor(.triOSTertiaryBackground, for: .normal)
        reserveButton.layer.cornerRadius = 20

        [batteryLabel, batteryRateLabel]
            .forEach { batteryLabelStackView.addArrangedSubview($0) }

        [batterIconView, batteryLabelStackView]
            .forEach { batteryView.addArrangedSubview($0) }

        [modelLabel, batteryView, priceLabel]
            .forEach { rightStackView.addArrangedSubview($0) }

        [imageView, rightStackView]
            .forEach { topStackView.addArrangedSubview($0) }

        batterIconView.addSubview(batteryIcon)

        [topStackView, reserveButton]
            .forEach { addSubview($0) }
    }

    private func configureConstraints() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(100)
        }

        modelLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
        }

        batteryView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.height.equalTo(48)
        }

        batteryIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30)
        }

        batterIconView.snp.makeConstraints {
            $0.size.equalTo(48)
        }

        topStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(12)
        }

        reserveButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(topStackView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview().inset(12)
        }
    }

    func updateUI(kickScooter: KickScooterUI) {
        imageView.image = UIImage(named: kickScooter.kickScooterType!.image)
        modelLabel.text = kickScooter.kickScooterType!.model
        batteryRateLabel.text = "\(kickScooter.battery.replacingOccurrences(of: ".0", with: ""))%"
        batteryIcon.image = BatteryLevel(desc: kickScooter.battery)!.symbolImage
        priceLabel.text = "\(kickScooter.kickScooterType!.price) 원"
    }

    @objc
    private func didReserveTapped() {
        onReserveTapped?()
    }
}
