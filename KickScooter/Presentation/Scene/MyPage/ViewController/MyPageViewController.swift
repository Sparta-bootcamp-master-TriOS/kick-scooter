import UIKit

final class MyPageViewController: UIViewController {
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
    }
}
