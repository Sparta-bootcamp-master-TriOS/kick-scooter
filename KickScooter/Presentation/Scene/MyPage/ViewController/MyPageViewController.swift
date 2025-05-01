import SnapKit
import UIKit

final class MyPageViewController: UIViewController {
    let collectionView = MyPageCollectionView()
    var dataSource: UICollectionViewDiffableDataSource<MyPageSection, MyPageItem>!

    let myPageViewModel: MyPageViewModel
    var userProfile: UserProfileUI?

    weak var delegate: MyPageViewControllerDelegate?

    init(myPageViewModel: MyPageViewModel) {
        self.myPageViewModel = myPageViewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myPageViewModel.action?(.fetchUserProfile)
        bindViewModelState()
        configureUI()
        configureAutoLayout()
        configureCompositionalLayout()
    }

    override func viewWillAppear(_: Bool) {
        locateCurrentCoordinate()
    }

    private func fetchProfileUser() -> UserProfileUI {
        myPageViewModel.fetchUserProfile()
    }

    private func bindViewModelState() {
        myPageViewModel.onStateChanged = { [weak self] state in
            guard let self else { return }
            switch state {
            case let .userProfile(userProfile):
                if userProfile.reservations.first?.status == true {
                    self.applySnapShot(with: userProfile)
                } else {
                    self.removeCurrentReservationSectionIfNeeded(userProfile)
                }
            }
        }
    }

    private func configureUI() {
        view.backgroundColor = .triOSBackground

        [
            collectionView,
        ]
        .forEach { view.addSubview($0) }
    }

    private func configureAutoLayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.directionalHorizontalEdges.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview()
        }
    }

    private func locateCurrentCoordinate() {
        myPageViewModel.locationManager.requestCurrentLocation(
            onAuthorized: { [weak self] coordinate in
                self?.myPageViewModel.updateCurrentLocation(coordinate)
                self?.collectionView.collectionView.reloadData()
            },
            onDenied: {}
        )
    }
}
