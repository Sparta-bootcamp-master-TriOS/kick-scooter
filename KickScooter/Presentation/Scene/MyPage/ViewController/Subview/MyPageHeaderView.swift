import SnapKit
import UIKit

final class MyPageHeaderView: UICollectionReusableView {
    static let identifier = "MyPageHeaderView"

    private let titleLabel = UILabel()

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        backgroundColor = .triOSBackground

        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .triOSText

        [
            titleLabel,
        ]
        .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configureHeader(_ title: String) {
        titleLabel.text = title
    }
}
