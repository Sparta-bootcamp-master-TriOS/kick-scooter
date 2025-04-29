import SnapKit
import UIKit

final class KickScooterCell: UICollectionViewCell {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    private func configureUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.size.equalTo(250)
        }
    }

    func updateUI(with name: String) {
        imageView.image = UIImage(named: name)
    }
}
