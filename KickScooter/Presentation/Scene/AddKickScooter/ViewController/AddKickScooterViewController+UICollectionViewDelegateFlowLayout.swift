import UIKit

extension AddKickScooterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        insetForSectionAt _: Int
    ) -> UIEdgeInsets {
        let sideInset = (collectionView.frame.width - 250) / 2

        return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
    }
}
