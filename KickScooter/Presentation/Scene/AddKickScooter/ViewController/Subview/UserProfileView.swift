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
        //
        profileImage.image = .defaultProfile
        wellcomLabel.text = "Good Morning 👋🏻"
        nameLabel.text = "Alina Joe"
        //

        wellcomLabel.font = .systemFont(ofSize: 14)
        wellcomLabel.textColor = .triOSTertiaryBackground

        nameLabel.font = .systemFont(ofSize: 22)
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
            $0.width.height.equalTo(64)
        }

        mainStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
