import UIKit

extension Coordinator: MainViewControllerDelegate {
    func makeMainViewController() -> MainViewController {
        let viewController = diContainer.makeMainViewController()
        viewController.delegate = self

        return viewController
    }

    func pushSignUp() {
        let viewController = makeSignUpViewController()
        navigationController.pushViewController(viewController, animated: true)
    }

    func toMap() {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first else { return }

        let viewController = diContainer.makeAddKickScooterViewController()

        UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: {
            window.rootViewController = viewController
        }, completion: nil)

        window.makeKeyAndVisible()
    }
}
