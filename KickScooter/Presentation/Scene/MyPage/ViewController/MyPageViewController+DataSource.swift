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
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: YourRideCell.identifier, for: indexPath
            ) as? YourRideCell else {
                fatalError("[Error] Failed Dequeue YourRide Cell")
            }

            guard case let .yourRide(reservation) = item else {
                fatalError("[Error] Invalid item type in yourRide section")
            }

            cell.updateUI(model: reservation.kickScooter.kickScooterType!.model)
            cell.configureProperty(reservation)
            cell.layer.cornerRadius = 10

            if let coordinate = myPageViewModel.currentLocation {
                cell.mapView.locateCurrentCoordinate(coordinate)
            }

            cell.onButtonTapped = { [weak self] in
                self?.showConfirmAlert(reservation)
            }

            return cell

        case .pastRides:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PastRidesCell.identifier, for: indexPath
            ) as? PastRidesCell else {
                fatalError("[Error] Failed Dequeue PastRides Cell")
            }

            guard case let .pastRides(reservation) = item else {
                fatalError("[Error] Invalid item type in pastRides section")
            }

            cell.configureProperty(reservation)
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
                guard let headerView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: MyPageHeaderView.identifier,
                    for: indexPath
                ) as? MyPageHeaderView else {
                    print("[Error] HeaderView casting failed")
                    return UICollectionReusableView()
                }

                if section == .yourRide || section == .pastRides {
                    headerView.isHidden = false
                    headerView.configureHeader(section.title)
                } else {
                    headerView.isHidden = true
                }

                return headerView

            default:
                return nil
            }
        }
    }

    // Data - Snapshot
    func applySnapShot(with userProfile: UserProfileUI?) {
        var snapshot = SnapShot<MyPageSection, MyPageItem>()
        guard let userProfile = userProfile else { return }

        let reservations = userProfile.reservations
        let latestReservation = reservations
            .filter { $0.status == true }
            .sorted(by: { $0.date > $1.date })
            .first

        let pastReservations = reservations
            .filter { $0.status == false }
            .sorted(by: { $0.date > $1.date })

        snapshot.appendSections([.userProfile, .yourRide, .pastRides, .signOutButton])

        snapshot.appendItems([.userProfile(userProfile)], toSection: .userProfile)

        if let latestReservation = latestReservation {
            snapshot.appendItems([.yourRide(latestReservation)], toSection: .yourRide)
        }

        if !pastReservations.isEmpty {
            snapshot.appendItems(pastReservations.map { .pastRides($0) }, toSection: .pastRides)
        }

        snapshot.appendItems([.signOutButton], toSection: .signOutButton)

        dataSource.apply(snapshot, animatingDifferences: true)
    }

    // 반납 버튼 눌렀을 때 ViewModel 에서 처리 완료 후, ViewController 에서 호출
    func removeCurrentReservationSectionIfNeeded(_ userProfile: UserProfileUI?) {
        var snapshot = dataSource.snapshot()

        if snapshot.sectionIdentifiers.contains(.yourRide) {
            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .yourRide))

            if let currentReservation = userProfile?.reservations.first(where: { $0.status == true }) {
                snapshot.appendItems([.yourRide(currentReservation)], toSection: .yourRide)
            } else {
                snapshot.appendItems([], toSection: .yourRide)
            }
        }

        if let userProfile = userProfile {
            let updatedReservations = userProfile.reservations
                .filter { $0.status == false }
                .sorted { $0.date > $1.date }

            let updatedItems = updatedReservations.map { MyPageItem.pastRides($0) }

            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .pastRides))
            snapshot.appendItems(updatedItems, toSection: .pastRides)
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
