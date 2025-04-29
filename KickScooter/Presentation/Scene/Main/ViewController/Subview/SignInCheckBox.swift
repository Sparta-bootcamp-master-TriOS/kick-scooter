import SnapKit
import UIKit

final class SignInCheckBox: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        tintColor = .triOSMain

        setTitleColor(.triOSText, for: .normal)
        setTitleColor(.triOSText, for: .selected)

        var config = UIButton.Configuration.plain()
        config.imagePadding = 8
        config.background.backgroundColor = .clear

        configuration = config

        configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            let image = button.isSelected ? "checkmark.square" : "square"
            updatedConfig?.image = UIImage(systemName: image)
            button.configuration = updatedConfig
        }

        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }

    @objc
    private func toggle() {
        isSelected.toggle()
    }
}
