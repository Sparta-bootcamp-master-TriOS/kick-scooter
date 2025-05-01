import UIKit

final class InvalidLabel: UILabel {
    var emptyText: String?
    var invalidText: String?
    var duplicatedIDText: String?

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
        font = .jalnan(ofSize: 16)
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

    func showduplicatedIDMessage() {
        text = duplicatedIDText
        isHidden = false
    }
}
