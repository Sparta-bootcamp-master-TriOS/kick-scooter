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

        layer.cornerRadius = 12
        clipsToBounds = true

        searchBar.placeholder = "Search Maps"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .triOSBackground

        if let glassIcon = searchBar.searchTextField.leftView as? UIImageView {
            glassIcon.tintColor = .triOSMain
        }

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = .triOSBackground
            textField.borderStyle = .none
        }

        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
