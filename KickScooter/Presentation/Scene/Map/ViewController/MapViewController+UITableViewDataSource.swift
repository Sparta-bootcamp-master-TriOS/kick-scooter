import UIKit

extension MapViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        mapViewModel.searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        cell.textLabel?.text = mapViewModel.searchResults[indexPath.row].addressName
        cell.backgroundColor = .triOSBackground
        return cell
    }
}
