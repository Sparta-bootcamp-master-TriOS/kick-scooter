import SnapKit
import UIKit

final class UserProfileView: UIView {
    private let profileImage = UIImageView()
    private let wellcomLabel = UILabel()
    private let nameLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configureUI() {
        wellcomLabel.font = .jalnan(ofSize: 14)
        wellcomLabel.textColor = .triOSTertiaryBackground

        nameLabel.font = .jalnan(ofSize: 22)
        nameLabel.textColor = .triOSTertiaryBackground

        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading

        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 10

        [wellcomLabel, nameLabel]
            .forEach { labelStackView.addArrangedSubview($0) }

        [profileImage, labelStackView]
            .forEach { mainStackView.addArrangedSubview($0) }

        addSubview(mainStackView)

        profileImage.snp.makeConstraints {
            $0.size.equalTo(64)
        }

        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateUI(wellcom: String, name: String, image: UIImage = UIImage.defaultProfile) {
        wellcomLabel.text = wellcom
        nameLabel.text = name
        profileImage.image = image
    }
}
