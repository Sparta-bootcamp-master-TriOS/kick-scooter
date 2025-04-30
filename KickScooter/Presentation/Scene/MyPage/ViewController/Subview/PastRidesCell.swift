import SnapKit
import UIKit

final class PastRidesCell: UICollectionViewCell {
    static let identifier = "PastRidesCell"

    private let dateLabel = UILabel()

    private let labelStackView = UIStackView()
    private let totalTimeLabel = UILabel()
    private let startLabel = UILabel()
    private let endLabel = UILabel()
    private let priceLabel = UILabel()

    private let valueStackView = UIStackView()
    private let totalTimeValue = UILabel()
    private let startValue = UILabel()
    private let endValue = UILabel()
    private let priceValue = UILabel()

    private let hStackView = UIStackView()

    private let scooterStackView = UIStackView()
    private let scooterImageView = UIImageView()
    private let scooterLabel = UILabel()

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
        backgroundColor = .triOSTertiaryBackground

        dateLabel.font = .boldSystemFont(ofSize: 16)
        dateLabel.textColor = .triOSText

        totalTimeLabel.text = "총 시간"
        totalTimeLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        totalTimeLabel.textColor = .triOSText

        startLabel.text = "시작"
        startLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        startLabel.textColor = .triOSText

        endLabel.text = "도착"
        endLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        endLabel.textColor = .triOSText

        priceLabel.text = "금액"
        priceLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        priceLabel.textColor = .triOSText

        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        labelStackView.alignment = .trailing

        totalTimeValue.font = .systemFont(ofSize: 11)
        totalTimeValue.textColor = .triOSText.withAlphaComponent(0.7)
        totalTimeValue.setContentCompressionResistancePriority(.required, for: .horizontal)

        startValue.font = .systemFont(ofSize: 11)
        startValue.textColor = .triOSText.withAlphaComponent(0.7)
        startValue.setContentCompressionResistancePriority(.required, for: .horizontal)

        endValue.font = .systemFont(ofSize: 11)
        endValue.textColor = .triOSText.withAlphaComponent(0.7)
        endValue.setContentCompressionResistancePriority(.required, for: .horizontal)

        priceValue.font = .systemFont(ofSize: 11)
        priceValue.textColor = .triOSText.withAlphaComponent(0.7)
        priceValue.setContentCompressionResistancePriority(.required, for: .horizontal)

        valueStackView.axis = .vertical
        valueStackView.spacing = 5
        valueStackView.alignment = .leading

        hStackView.axis = .horizontal
        hStackView.spacing = 16

        scooterStackView.axis = .vertical
        scooterStackView.spacing = 7
        scooterStackView.alignment = .center

        scooterImageView.contentMode = .scaleAspectFit
        scooterImageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        scooterLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        scooterLabel.textColor = .triOSSecondaryText
        scooterLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        [
            dateLabel,
            hStackView,
            scooterStackView,
        ]
        .forEach { addSubview($0) }

        [
            totalTimeLabel,
            startLabel,
            endLabel,
            priceLabel,
        ]
        .forEach { labelStackView.addArrangedSubview($0) }

        [
            totalTimeValue,
            startValue,
            endValue,
            priceValue,
        ]
        .forEach { valueStackView.addArrangedSubview($0) }

        [
            labelStackView,
            valueStackView,
        ]
        .forEach { hStackView.addArrangedSubview($0) }

        [
            scooterImageView,
            scooterLabel,
        ]
        .forEach { scooterStackView.addArrangedSubview($0) }
    }

    func configureProperty(_ reservation: ReservationUI) {
        dateLabel.text = reservation.date
    }

    func configurePropertyMock(_ pastRide: PastRidesMock) {
        dateLabel.text = pastRide.date
        totalTimeValue.text = pastRide.totalTime
        startValue.text = pastRide.start
        endValue.text = pastRide.end
        scooterImageView.image = UIImage(named: pastRide.scooterImg)
        scooterLabel.text = pastRide.scooterModel
        priceValue.text = pastRide.priceValue
    }

    private func configureAutoLayout() {
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(200)
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalToSuperview().offset(16)
        }

        hStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.top.equalTo(dateLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(20)
        }

        scooterImageView.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(78)
        }

        scooterStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
}
