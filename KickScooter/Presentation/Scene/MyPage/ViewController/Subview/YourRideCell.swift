import SnapKit
import UIKit

final class YourRideCell: UICollectionViewCell {
    static let identifier = "YourRideCell"

    let mapView = MyPageMap()

    private let reservationView = UIView()

    private let confirmLabel = UILabel()

    private let naviImage = UIImageView()
    private let totalTime = UILabel()
    private let timeStackView = UIStackView()

    private let batteryIconView = UIView()
    private let batteryIcon = UIImageView()

    private let batteryLabel = UILabel()
    private let batteryValue = UILabel()
    private let batteryVstackView = UIStackView()

    private let scooterImageView = UIImageView()

    private let returnButton = UIButton()

    var onButtonTapped: ((ReservationUI) -> Void)?

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureAutoLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .triOSBackground

        mapView.layer.cornerRadius = 19
        mapView.layer.cornerRadius = 19
        mapView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
        ]
        reservationView.clipsToBounds = true

        reservationView.backgroundColor = .triOSTertiaryBackground
        reservationView.layer.cornerRadius = 19
        reservationView.layer.maskedCorners = [
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner,
        ]
        reservationView.clipsToBounds = false
        reservationView.layer.borderWidth = 1.0
        reservationView.layer.borderColor = UIColor.triOSSecondaryText.withAlphaComponent(0.3).cgColor

        confirmLabel.text = "Ride Confirm"
        confirmLabel.font = .jalnan(ofSize: 18)
        confirmLabel.textColor = .triOSText

        naviImage.image = UIImage(systemName: "location.fill")
        naviImage.tintColor = .triOSMain
        naviImage.contentMode = .scaleAspectFill

        totalTime.font = .jalnan(ofSize: 13)
        totalTime.textColor = .triOSText

        timeStackView.axis = .horizontal
        timeStackView.spacing = 9
        timeStackView.alignment = .trailing

        batteryIconView.layer.cornerRadius = 24
        batteryIconView.backgroundColor = .triOSHighBatteryBackground

        batteryIcon.contentMode = .center
        batteryIcon.tintColor = .triOSHighBattery

        batteryLabel.text = "배터리"
        batteryLabel.font = .jalnan(ofSize: 12)
        batteryLabel.textColor = .triOSSecondaryText

        batteryValue.font = .jalnan(ofSize: 12)
        batteryValue.textColor = .triOSText

        batteryVstackView.axis = .vertical
        batteryVstackView.spacing = 1
        batteryVstackView.alignment = .leading

        scooterImageView.image = UIImage(named: KickScooterType.expensive.image)
        scooterImageView.contentMode = .scaleAspectFill

        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.titleAlignment = .center
        config.title = "반납"
        config.baseBackgroundColor = .triOSRedButton
        config.baseForegroundColor = .triOSTertiaryBackground
        returnButton.configuration = config

        let action = UIAction { [weak self] _ in
            self?.tapped()
        }
        returnButton.addAction(action, for: .touchUpInside)

        [
            mapView,
            reservationView,
        ]
        .forEach { addSubview($0) }

        [
            confirmLabel,
            timeStackView,
            batteryIconView,
            batteryVstackView,
            scooterImageView,
            returnButton,
        ]
        .forEach { reservationView.addSubview($0) }

        [
            batteryIcon,
        ]
        .forEach { batteryIconView.addSubview($0) }

        [
            naviImage,
            totalTime,
        ]
        .forEach { timeStackView.addArrangedSubview($0) }

        [
            batteryLabel,
            batteryValue,
        ]
        .forEach { batteryVstackView.addArrangedSubview($0) }
    }

    private func tapped() {
        onButtonTapped?(
            ReservationUI(
                date: Date(), //
                status: false, //
                startLon: 0,
                startLat: 0,
                endLon: 0, // from map
                endLat: 0, // from map
                startAddress: "",
                endAddress: "",
                totalTime: "",
                totalPrice: "",
                kickScooter: KickScooterUI(
                    id: UUID(),
                    battery: "",
                    type: 0,
                    lon: 0,
                    lat: 0,
                    isAvailable: true //
                )
            )
        )
    }

    func configureProperty(_ reservation: ReservationUI) {
        totalTime.text = Formatter.getTotalTime(from: reservation.date)

        if let image = KickScooterType(rawValue: reservation.kickScooter.type)?.image {
            scooterImageView.image = UIImage(named: image)
        }

        if let battery = Double(reservation.kickScooter.battery),
           let batteryLevel = BatteryLevel(desc: battery)
        {
            switch batteryLevel {
            case .high:
                batteryIconView.backgroundColor = .triOSHighBatteryBackground
                batteryIcon.image = UIImage(systemName: "battery.100")
                batteryIcon.tintColor = .triOSHighBattery
                batteryValue.text = "\(Int(battery))%"
            case .mid:
                batteryIconView.backgroundColor = .triOSMidBatteryBackground
                batteryIcon.image = UIImage(systemName: "battery.50")
                batteryIcon.tintColor = .triOSMidBattery
                batteryValue.text = "\(Int(battery))%"
            case .low:
                batteryIconView.backgroundColor = .triOSLowBatteryBackground
                batteryIcon.image = UIImage(systemName: "battery.25")
                batteryIcon.tintColor = .triOSLowBattery
                batteryValue.text = "\(Int(battery))%"
            }
        }
    }

    private func configureAutoLayout() {
        mapView.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(200)
        }

        reservationView.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.bottom.directionalHorizontalEdges.equalToSuperview()
        }

        confirmLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(reservationView.snp.top).offset(14)
        }

        naviImage.snp.makeConstraints {
            $0.size.equalTo(17)
        }

        timeStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(14)
        }

        batteryIconView.snp.makeConstraints {
            $0.top.equalTo(confirmLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(48)
        }

        batteryIcon.snp.makeConstraints {
            $0.center.equalTo(batteryIconView.snp.center)
            $0.width.equalTo(29)
            $0.height.equalTo(16)
        }

        batteryVstackView.snp.makeConstraints {
            $0.centerY.equalTo(batteryIconView.snp.centerY)
            $0.leading.equalTo(batteryIconView.snp.trailing).offset(10)
        }

        scooterImageView.snp.makeConstraints {
            $0.size.equalTo(72)
            $0.top.equalTo(timeStackView.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().inset(10)
        }

        returnButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(36)
            $0.bottom.equalToSuperview().inset(19)
        }
    }
}
