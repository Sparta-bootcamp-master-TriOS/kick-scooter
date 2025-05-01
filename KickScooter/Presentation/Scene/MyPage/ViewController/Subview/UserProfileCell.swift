import SnapKit
import UIKit

final class UserProfileCell: UICollectionViewCell {
    static let identifier = "ProfileCell"

    private var titleLabel = UILabel()
    private var idLabel = UILabel()
    private var emailLabel = UILabel()
    private var vStackView = UIStackView()

    private var profileImageView = UIImageView()

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureAutoLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureProperty(_ userProfile: UserProfileUI) {
        titleLabel.text = userProfile.name
        idLabel.text = userProfile.id
        emailLabel.text = userProfile.email
    }

    private func configureUI() {
        backgroundColor = .triOSBackground

        titleLabel.font = .jalnan(ofSize: 22)
        titleLabel.textColor = .triOSText

        idLabel.font = .jalnan(ofSize: 12)
        idLabel.textColor = .triOSText.withAlphaComponent(0.7)

        emailLabel.font = .jalnan(ofSize: 12)
        emailLabel.textColor = .triOSText.withAlphaComponent(0.7)

        vStackView.axis = .vertical
        vStackView.spacing = 2
        vStackView.alignment = .leading

        profileImageView.image = UIImage(named: "DefaultProfile")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 10
        profileImageView.backgroundColor = .triOSMidBattery

        [
            vStackView,
            profileImageView,
        ]
        .forEach { addSubview($0) }

        [
            titleLabel,
            idLabel,
            emailLabel,
        ]
        .forEach { vStackView.addArrangedSubview($0) }
    }

    private func configureAutoLayout() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(27)
        }

        idLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }

        emailLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }

        profileImageView.snp.makeConstraints {
            $0.size.equalTo(70)
            $0.trailing.top.equalToSuperview()
        }

        vStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }
}
