import SnapKit
import UIKit

final class MapSearchBarWrapperView: UIView {
    private let mapSearchBarView = MapSearchBarView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShadow()
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureShadow() {
        backgroundColor = .clear
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }

    private func configureUI() {
        addSubview(mapSearchBarView)

        mapSearchBarView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    var searchBar: UISearchBar {
        mapSearchBarView.searchBar
    }
}
