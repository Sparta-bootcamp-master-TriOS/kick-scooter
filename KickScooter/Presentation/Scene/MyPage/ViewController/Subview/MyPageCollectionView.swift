import SnapKit
import UIKit

final class MyPageCollectionView: UIView {
    // MARK: - Components

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout()
        )
        collectionView.register(UserProfileCell.self, forCellWithReuseIdentifier: UserProfileCell.identifier)
        collectionView.register(PastRidesCell.self, forCellWithReuseIdentifier: PastRidesCell.identifier)
        collectionView.register(SignOutButtonCell.self, forCellWithReuseIdentifier: SignOutButtonCell.identifier)

        collectionView.register(
            MyPageHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: MyPageHeaderView.identifier
        )

        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    // MARK: - Init

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        configureUI()
        configureAutoLayout()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    private func configureUI() {
        collectionView.backgroundColor = .triOSBackground

        [
            collectionView,
        ]
        .forEach { addSubview($0) }
    }

    private func configureAutoLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MyPageCollectionView {
    private func layout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            // sectionIndex : 현재 섹션의 번호
            // _ (= environment : 화면 사이즈,  traits 등 정보 포함
            let section = MyPageSection.allCases[sectionIndex]

            // 1. 공통 Item, Group 정의
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(90)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(50)
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.interItemSpacing = .fixed(15)

            let sectionLayout = NSCollectionLayoutSection(group: group)
            sectionLayout.interGroupSpacing = 15
            sectionLayout.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)

            // 2. 섹션에 따라 Header 추가
//            if section == .yourRide || section == .pastRides {
            if section == .pastRides {
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                )

                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                sectionLayout.boundarySupplementaryItems = [header]
            }

            return sectionLayout
        }
    }
}
