import SnapKit
import UIKit

final class UserProfileCell: UICollectionViewCell {
    static let identifier = "ProfileCell"

    private var titleLabel = UILabel()
    private var idLabel = UILabel()
    private var emailLabel = UILabel()
    private var vStackView = UIStackView()
    private var profileImageView = UIImageView()
    private var hStackView = UIStackView()

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

        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .triOSText

        idLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        idLabel.textColor = .triOSText.withAlphaComponent(0.7)

        emailLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        emailLabel.textColor = .triOSText.withAlphaComponent(0.7)

        vStackView.axis = .vertical
        vStackView.spacing = 5
        vStackView.alignment = .leading

        profileImageView.image = UIImage(named: "DefaultProfile")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 10
        profileImageView.backgroundColor = .triOSMidBattery

        hStackView.axis = .horizontal
        hStackView.distribution = .fill

        [
            vStackView,
            hStackView,
        ]
        .forEach { addSubview($0) }

        [
            titleLabel,
            idLabel,
            emailLabel,
        ]
        .forEach { vStackView.addArrangedSubview($0) }

        [
            vStackView,
            profileImageView,
        ]
        .forEach { hStackView.addArrangedSubview($0) }
    }

    private func configureAutoLayout() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(64)
        }

        hStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
