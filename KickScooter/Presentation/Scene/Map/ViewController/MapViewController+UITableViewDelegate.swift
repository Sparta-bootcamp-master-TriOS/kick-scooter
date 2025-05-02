import UIKit

extension MapViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = mapViewModel.searchResults[indexPath.row]
        mapSearchResultView.onItemSelected?(selected)
        mapSearchBarWrapperView.searchBar.text = selected.addressName
    }
}
