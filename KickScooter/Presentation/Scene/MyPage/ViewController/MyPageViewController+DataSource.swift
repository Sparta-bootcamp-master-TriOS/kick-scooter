import UIKit

extension MyPageViewController {
    typealias DataSource = UICollectionViewDiffableDataSource
    typealias SnapShot = NSDiffableDataSourceSnapshot

    func configureCompositionalLayout() {
        dataSource = makeDataSource()
        makeSupplementaryViewProvider()
        applySnapShot(with: myPageViewModel.userProfile)
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
        let sections = dataSource.snapshot().sectionIdentifiers
        let section = sections[indexPath.section]

        switch section {
        case .userProfile:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserProfileCell.identifier, for: indexPath
            ) as? UserProfileCell else {
                fatalError("[Error] Failed Dequeue UserProfile Cell")
            }

            guard case let .userProfile(userProfileUI) = item else {
                fatalError("[Error] Failed Fetch UserProfile Item")
            }

            cell.configureProperty(userProfileUI)
            return cell

        case .yourRide:
            guard case let .yourRide(latestReservation) = item else {
                print("[Error] Failed Fetch YourRide Item")
                return UICollectionViewCell()
            }

            guard latestReservation.status == true else {
                print("[Warning] reservation.status == false → 셀 생성하지 않음")
                return UICollectionViewCell()
            }

            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: YourRideCell.identifier, for: indexPath
            ) as? YourRideCell else {
                fatalError("[Error] Failed Dequeue YourRide Cell")
            }

            cell.configureProperty(latestReservation)
            cell.layer.cornerRadius = 10

            if let coordinate = myPageViewModel.currentLocation {
                cell.mapView.locateCurrentCoordinate(coordinate)
            }

            // Return Button Tapped
            cell.onButtonTapped = { [weak self] reservation in
                self?.showConfirmAlert(reservation)
            }

            return cell

        case .pastRides:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PastRidesCell.identifier, for: indexPath
            ) as? PastRidesCell else {
                fatalError("[Error] Failed Dequeue PastRides Cell")
            }

            guard case let .pastRides(pastRide) = item else {
                fatalError("[Error] Failed Fetch PastRides Item")
            }

            cell.configureProperty(pastRide)
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.triOSSecondaryText.withAlphaComponent(0.3).cgColor
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
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let self else { return nil }
            switch kind {
            case UICollectionView.elementKindSectionHeader:

                let section = MyPageSection.allCases[indexPath.section]

                guard let headerView = collectionView
                    .dequeueReusableSupplementaryView(
                        ofKind: UICollectionView.elementKindSectionHeader,
                        withReuseIdentifier: MyPageHeaderView.identifier,
                        for: indexPath
                    ) as? MyPageHeaderView
                else {
                    print("[Error] HeaderView casting failed")
                    return UICollectionReusableView() // fallback: 최소한 뭔가 리턴
                }

                if section == .yourRide || section == .pastRides {
                    if let userProfile = self.myPageViewModel.userProfile,
                       !userProfile.reservations.isEmpty
                    {
                        let reservations = userProfile.reservations
                        if section == .yourRide,
                           let resetvation = reservations.sorted(by: { $0.date > $1.date }).first,
                           resetvation.status == false
                        {
                            headerView.isHidden = true
                            return headerView
                        }

                        headerView.isHidden = false
                        headerView.configureHeader(section.title)
                        return headerView
                    }
                }
                headerView.isHidden = true
                return headerView

            default:
                return nil
            }
        }
    }

    // Data - Snapshot
    func applySnapShot(with userProfile: UserProfileUI?) {
        var snapshot = SnapShot<MyPageSection, MyPageItem>()

        // UserProfile Section
        guard let userProfile = userProfile else {
            return
        }
        snapshot.appendSections([.userProfile])
        snapshot.appendItems(
            [.userProfile(userProfile)],
            toSection: .userProfile
        )

        // YourRide Section
        let reservations = userProfile.reservations
        if !reservations.isEmpty,
           let latestReservation = reservations.sorted(by: { $0.date > $1.date }).first,
           latestReservation.status == true
        {
            snapshot.appendSections([.yourRide])
            snapshot.appendItems(
                [.yourRide(latestReservation)],
                toSection: .yourRide
            )
        }

        // PastRides Section
        if !reservations.isEmpty {
            let sortedReservation = reservations.sorted(by: { $0.date > $1.date })
            snapshot.appendSections([.pastRides])
            snapshot.appendItems(
                sortedReservation.map {
                    MyPageItem.pastRides($0)
                },
                toSection: .pastRides
            )
        }

        // SignOut Section
        snapshot.appendSections([.signOutButton])
        snapshot.appendItems([.signOutButton], toSection: .signOutButton)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // 반납 버튼 눌렀을 때 ViewModel 에서 처리 완료 후, ViewController 에서 호출
    func removeCurrentReservationSectionIfNeeded(_ userProfile: UserProfileUI?) {
        var snapshot = dataSource.snapshot()

        // 1. .yourRide Section 제거
        if snapshot.sectionIdentifiers.contains(.yourRide) {
            snapshot.deleteSections([.yourRide])
        }

        // 2. .pastRides 데이터 갱신
        if let userProfile = userProfile {
            let updatedReservations = userProfile.reservations.sorted { $0.date > $1.date }
            let updatedItem = updatedReservations.map { MyPageItem.pastRides($0) }

            // 기존 pastRides 아이템 제거 후 새로 추가
            snapshot.deleteItems(
                snapshot.itemIdentifiers(inSection: .pastRides)
            )
            snapshot.appendItems(updatedItem, toSection: .pastRides)
        }

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private func showConfirmAlert(_ reservation: ReservationUI) {
        let alert = UIAlertController(title: "반납하기", message: "킥보드를 반납하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            self?.myPageViewModel.action?(.updateReservation(reservation))
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
}
