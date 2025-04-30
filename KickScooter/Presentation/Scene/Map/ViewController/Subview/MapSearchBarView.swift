import SnapKit
import UIKit

final class MapSearchBarView: UIView {
    let searchBar = UISearchBar()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        addSubview(searchBar)

        backgroundColor = .triOSBackground
        layer.cornerRadius = 12
        clipsToBounds = true

        searchBar.placeholder = "Search Maps"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .triOSBackground

        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
