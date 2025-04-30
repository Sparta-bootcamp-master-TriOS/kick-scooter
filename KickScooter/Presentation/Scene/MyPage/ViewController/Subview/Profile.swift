import SnapKit
import UIKit

final class Profile: UIView {
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

        idLabel.font = .boldSystemFont(ofSize: 11)
        idLabel.textColor = .triOSSecondaryText

        emailLabel.font = .boldSystemFont(ofSize: 11)
        emailLabel.textColor = .triOSSecondaryText

        vStackView.axis = .vertical
        vStackView.spacing = 5
        vStackView.alignment = .leading

        profileImageView.image = UIImage(named: "DefaultProfile")
        profileImageView.contentMode = .scaleAspectFill
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
