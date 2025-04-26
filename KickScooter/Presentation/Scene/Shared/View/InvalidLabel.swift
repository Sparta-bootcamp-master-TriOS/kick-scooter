import UIKit

final class InvalidLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        textColor = .triOSLowBattery
        font = .systemFont(ofSize: 16)
        isHidden = true
    }
}
