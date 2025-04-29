import UIKit

final class CenteredFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(
        forProposedContentOffset proposedContentOffset: CGPoint,
        withScrollingVelocity velocity: CGPoint
    ) -> CGPoint {
        guard let collectionView = collectionView else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
            )
        }

        let collectionViewSize = collectionView.bounds.size
        let proposedContentOffsetCenterX = proposedContentOffset.x + collectionViewSize.width / 2

        let visibleAttributes = layoutAttributesForElements(in: collectionView.bounds)

        let closest = visibleAttributes?.min(by: {
            abs($0.center.x - proposedContentOffsetCenterX) < abs($1.center.x - proposedContentOffsetCenterX)
        })

        guard let closestAttributes = closest else {
            return super.targetContentOffset(
                forProposedContentOffset: proposedContentOffset,
                withScrollingVelocity: velocity
            )
        }

        let targetOffsetX = closestAttributes.center.x - collectionViewSize.width / 2
        return CGPoint(x: targetOffsetX, y: proposedContentOffset.y)
    }
}
