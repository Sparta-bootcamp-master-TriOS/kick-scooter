import UIKit

extension AddKickScooterViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.width))

        pageControl.currentPage = index
        addKickScooterViewModel.selectedKickScooter(at: index)
    }
}
