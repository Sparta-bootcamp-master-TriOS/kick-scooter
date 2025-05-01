import UIKit

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        mapViewModel.searchAddress(query: text)
        searchBar.resignFirstResponder()
    }
}
