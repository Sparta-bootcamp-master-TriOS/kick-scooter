import UIKit

final class InvalidLabel: UILabel {
    var emptyText: String?
    var invalidText: String?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        text = " "
        textColor = .triOSLowBattery
        font = .systemFont(ofSize: 16)
        isHidden = true
    }

    func showEmptyMessage() {
        text = emptyText
        isHidden = false
    }

    func showInvalidMessage() {
        text = invalidText
        isHidden = false
    }
}
