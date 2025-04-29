import UIKit

final class KickScooterDetailView: UIView {
    private let modelLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        modelLabel.textColor = .triOSText
        modelLabel.font = .boldSystemFont(ofSize: 24)

        [modelLabel, priceLabel]
            .forEach { addSubview($0) }

        modelLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }

    func updateUI(with model: String, _ price: String) {
        modelLabel.text = model

        let fullText = "₩\(price) / 시간"
        let attributedString = NSMutableAttributedString(string: fullText)

        if let priceRange = fullText.range(of: "₩\(price)") {
            let nsRange = NSRange(priceRange, in: fullText)
            attributedString.addAttributes([
                .foregroundColor: UIColor.triOSRedButton,
                .font: UIFont.systemFont(ofSize: 24),
            ], range: nsRange)
        }

        if let timeRange = fullText.range(of: "/ 시간") {
            let nsRange = NSRange(timeRange, in: fullText)
            attributedString.addAttributes([
                .foregroundColor: UIColor.triOSSecondaryText,
                .font: UIFont.systemFont(ofSize: 16),
            ], range: nsRange)
        }

        priceLabel.attributedText = attributedString
    }
}
