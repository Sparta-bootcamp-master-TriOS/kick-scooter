import UIKit

extension MapViewController: UISearchBarDelegate {
    func searchBarInput(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        mapViewModel.searchAddress(query: text)
        searchBar.resignFirstResponder()
    }
}
