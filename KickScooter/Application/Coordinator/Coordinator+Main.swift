extension Coordinator: MainViewControllerDelegate {
    func makeMainViewController() -> MainViewController {
        let viewController = diContainer.makeMainViewController()
        viewController.delegate = self

        return viewController
    }

    func pushSignUp() {
        let viewController = diContainer.makeSignUpViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
