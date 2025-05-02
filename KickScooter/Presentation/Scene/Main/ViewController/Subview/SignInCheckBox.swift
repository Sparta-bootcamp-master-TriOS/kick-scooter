import SnapKit
import UIKit

final class SignInCheckBox: UIButton {
    var onToggle: ((Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        var config = UIButton.Configuration.plain()
        config.imagePadding = 8
        config.background.backgroundColor = .clear
        config.baseForegroundColor = .triOSText
        config.imageColorTransformer = UIConfigurationColorTransformer { _ in .triOSMain }

        configuration = config

        configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            let image = button.isSelected ? "checkmark.square" : "square"
            updatedConfig?.image = UIImage(systemName: image)
            button.configuration = updatedConfig
        }

        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }

    func updateTitle(_ title: String) {
        let config = AttributedString(
            title,
            attributes: AttributeContainer([.font: UIFont.jalnan(ofSize: 16)])
        )
        configuration?.attributedTitle = config
    }

    @objc
    private func toggle() {
        isSelected.toggle()
        onToggle?(isSelected)
    }
}
