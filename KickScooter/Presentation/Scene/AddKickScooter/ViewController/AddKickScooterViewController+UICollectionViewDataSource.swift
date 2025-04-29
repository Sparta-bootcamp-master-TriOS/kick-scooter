import UIKit

extension AddKickScooterViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        KickScooterType.allCases.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "KickScooterCell", for: indexPath
        ) as? KickScooterCell else {
            return UICollectionViewCell()
        }

        let kickScooter = KickScooterType.allCases[indexPath.item]
        cell.updateUI(with: kickScooter.image)

        return cell
    }
}
