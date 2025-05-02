import UIKit

extension Coordinator: MyPageViewControllerDelegate {
    func makeMyPageViewController() -> MyPageViewController {
        let viewController = diContainer.makeMyPageViewController()
        viewController.delegate = self

        return viewController
    }

    func successSignOut() {
        start()

        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first else { return }

        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionFlipFromLeft,
            animations: {
                window.rootViewController = self.navigationController
            },
            completion: { _ in
                window.makeKeyAndVisible()
            }
        )
    }
}
