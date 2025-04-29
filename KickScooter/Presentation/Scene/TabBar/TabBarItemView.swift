import SnapKit
import UIKit

final class TabBarItemView: UIView {
    let imageView = UIImageView()

    init(image: UIImage, isSelected: Bool) {
        super.init(frame: .zero)

        setupUI(image, isSelected)
    }

    required init?(coder _: NSCoder) {
        nil
    }

    override func point(inside _: CGPoint, with _: UIEvent?) -> Bool {
        return false
    }

    private func setupUI(_ image: UIImage, _ isSelected: Bool) {
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = isSelected ? .white : .black
        imageView.contentMode = .scaleAspectFit

        let container = UIView()
        container.backgroundColor = isSelected ? UIColor.triOSMain : .clear
        container.layer.cornerRadius = 24

        container.addSubview(imageView)

        addSubview(container)

        container.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(48)
        }

        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(30)
        }
    }
}
