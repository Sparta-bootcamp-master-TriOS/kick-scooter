import SnapKit
import UIKit

final class MyPageViewController: UIViewController {
    private let profileView = Profile()
    private let myPageViewModel: MyPageViewModel

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
        configureProfileView(fetchProfileUser())
        configureUI()
        configureAutoLayout()
    }

    private func configureProfileView(_ userProfile: UserProfileUI) {
        profileView.configureProperty(userProfile)
    }

    private func fetchProfileUser() -> UserProfileUI {
        myPageViewModel.fetchUserProfile()
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground

        [
            profileView,
        ]
        .forEach { view.addSubview($0) }
    }

    private func configureAutoLayout() {
        profileView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.directionalHorizontalEdges.equalToSuperview().inset(31)
        }
    }
}
