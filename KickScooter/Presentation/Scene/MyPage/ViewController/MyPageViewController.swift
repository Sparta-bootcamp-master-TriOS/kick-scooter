import SnapKit
import UIKit

final class MyPageViewController: UIViewController {
    let collectionView = MyPageCollectionView()
    var dataSource: UICollectionViewDiffableDataSource<MyPageSection, MyPageItem>!

    let myPageViewModel: MyPageViewModel

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
        configureUI()
        configureAutoLayout()
        configureCompositionalLayout()
    }

    private func fetchProfileUser() -> UserProfileUI {
        myPageViewModel.fetchUserProfile()
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
}
