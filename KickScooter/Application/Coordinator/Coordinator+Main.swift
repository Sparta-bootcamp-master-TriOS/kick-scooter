extension Coordinator: MainViewControllerDelegate {
    func makeMainViewController() -> MainViewController {
        let viewController = diContainer.makeMainViewController()
        viewController.delegate = self

        return viewController
    }

    func push() {
        let viewController = makeSignUpViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
