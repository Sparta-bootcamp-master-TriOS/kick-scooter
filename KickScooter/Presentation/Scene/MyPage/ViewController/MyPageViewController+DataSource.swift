import UIKit

extension MyPageViewController {
    typealias DataSource = UICollectionViewDiffableDataSource
    typealias SnapShot = NSDiffableDataSourceSnapshot

    func configureCompositionalLayout() {
        dataSource = makeDataSource()
        makeSupplementaryViewProvider()
        applySnapShot()
    }

    // Presentation - Diffable DataSource 생성
    private func makeDataSource() -> DataSource<MyPageSection, MyPageItem> {
        UICollectionViewDiffableDataSource<MyPageSection, MyPageItem>(collectionView: collectionView.collectionView, cellProvider: { [weak self] collectionView, indexPath, item in
            self?.makeCell(collectionView, indexPath, item)
        })
    }

    // Presentation - Cell Provider 구현
    private func makeCell(
        _ collectionView: UICollectionView,
        _ indexPath: IndexPath,
        _ item: MyPageItem
    ) -> UICollectionViewCell {
        let section = MyPageSection.allCases[indexPath.section]
        switch section {
        case .userProfile:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserProfileCell.identifier, for: indexPath
            ) as? UserProfileCell else {
                return UICollectionViewCell()
            }

            guard case let .userProfile(userProfileUI) = item else {
                return UICollectionViewCell()
            }

            cell.configureProperty(userProfileUI)
            return cell
//        case .yourRide:
//            return UICollectionViewCell()
        case .pastRides:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PastRidesCell.identifier, for: indexPath
            ) as? PastRidesCell else {
                return UICollectionViewCell()
            }

            guard case let .pastRides(pastRide) = item else {
                return UICollectionViewCell()
            }

            cell.configurePropertyMock(pastRide)
            cell.layer.cornerRadius = 10
            cell.layer.shadowColor = UIColor.gray.cgColor
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.clipsToBounds = false
            cell.layer.masksToBounds = false
            cell.layer.shadowPath = UIBezierPath(
                roundedRect: cell.bounds,
                cornerRadius: cell.contentView.layer.cornerRadius
            ).cgPath

            return cell
        case .signOutButton:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SignOutButtonCell.identifier,
                for: indexPath
            ) as? SignOutButtonCell else {
                return UICollectionViewCell()
            }

            cell.onTapped = { [weak self] in
                self?.myPageViewModel.signOut()
                self?.delegate?.successSignOut()
            }

            return cell
        }
    }

    // Header
    private func makeSupplementaryViewProvider() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in

            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let section = MyPageSection.allCases[indexPath.section]
                //            if section == .yourRide || section == .pastRides {
                if section == .pastRides {
                    let headerView = collectionView
                        .dequeueReusableSupplementaryView(
                            ofKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: MyPageHeaderView.identifier,
                            for: indexPath
                        ) as? MyPageHeaderView
                    headerView?.configureHeader(section.title)
                    return headerView
                }
                return nil

            case UICollectionView.elementKindSectionFooter:
                return nil

            default:
                return nil
            }
        }
    }

    // Data - Snapshot
    private func applySnapShot() {
        var snapshot = SnapShot<MyPageSection, MyPageItem>()
        snapshot.appendSections(MyPageSection.allCases)

        snapshot.appendItems(
            [.userProfile(myPageViewModel.fetchUserProfile())],
            toSection: .userProfile
        )
//        snapshot.appendItems(
//            [.yourRide],
//            toSection: .yourRide
//        )
        snapshot.appendItems(
            PastRidesMock.pastRidesMock
                .map {
                    MyPageItem.pastRides($0)
                },
            toSection: .pastRides
        )
        snapshot.appendItems([.signOutButton], toSection: .signOutButton)

        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
